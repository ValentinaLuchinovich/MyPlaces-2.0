ROOT_DIR="${PROJECT_DIR}"

# Сохранение корневой папки проекта
function run_swiftgen {
    echo "Running swiftgen in $1"
    cd "$1" || return
    $ROOT_DIR/swiftgen/bin/swiftgen
    cd - || return
}

# Обход всех папок рекурсивно и выполнение swiftgen, если найден swiftgen.yml
find . -name "swiftgen.yml" | while read -r filepath; do
    directory=$(dirname "$filepath")
    run_swiftgen "$directory"
done
