#!/bin/bash

# sysopctl v0.1.0 - A system resource management tool
VERSION="v0.1.0"

# Help function
show_help() {
    echo "Usage: sysopctl [command] [options]"
    echo "Commands:"
    echo "  service list            - List running services"
    echo "  service start <name>    - Start a service"
    echo "  service stop <name>     - Stop a service"
    echo "  system load             - View system load"
    echo "  disk usage              - Check disk usage"
    echo "  process monitor         - Monitor system processes"
    echo "  logs analyze            - Analyze system logs"
    echo "  backup <path>           - Backup system files"
    echo "  --help                  - Show this help message"
    echo "  --version               - Show version information"
}

# Version function
show_version() {
    echo "sysopctl version $VERSION"
}

# Command functions
list_services() {
    systemctl list-units --type=service
}
view_system_load() {
    uptime
}
start_service() {
    systemctl start "$1"
}
stop_service() {
    systemctl stop "$1"
}
check_disk_usage() {
    df -h
}
monitor_processes() {
    top
}
analyze_logs() {
    journalctl -p crit
}
backup_files() {
    if [ ! -d "/backup/" ]; then
        mkdir -p /backup/
    fi
    rsync -avh "$1" /backup/
}

# Parse commands
case "$1" in
    --help)
        show_help
        ;;
    --version)
        show_version
        ;;
    service)
        case "$2" in
            list)
                list_services
                ;;
            start)
                start_service "$3"
                ;;
            stop)
                stop_service "$3"
                ;;
            *)
                echo "Invalid service command. Use --help for available options."
                ;;
        esac
        ;;
    system)
        case "$2" in
            load)
                view_system_load
                ;;
            *)
                echo "Invalid system command. Use --help for available options."
                ;;
        esac
        ;;
    disk)
        case "$2" in
            usage)
                check_disk_usage
                ;;
            *)
                echo "Invalid disk command. Use --help for available options."
                ;;
        esac
        ;;
    process)
        case "$2" in
            monitor)
                monitor_processes
                ;;
            *)
                echo "Invalid process command. Use --help for available options."
                ;;
        esac
        ;;
    logs)
        case "$2" in
            analyze)
                analyze_logs
                ;;
            *)
                echo "Invalid logs command. Use --help for available options."
                ;;
        esac
        ;;
    backup)
        backup_files "$2"
        ;;
    *)
        echo "Invalid command. Use --help for available options."
        ;;
esac
