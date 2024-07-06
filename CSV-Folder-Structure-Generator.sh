#!/bin/zsh

output_file="folder_structure.csv"

get_max_depth() {
    local base_dir=$1
    find "$base_dir" -type d | while read -r dir; do
        echo "${dir#$base_dir}" | awk -F/ '{print NF-1}'
    done | sort -rn | head -1
}

create_csv() {
    local base_dir=$1
    local extensions=($2)
    local include_hidden=$3
    local max_depth=$(get_max_depth "$base_dir")

    # Scrive l'intestazione nel file CSV
    echo -n "Main Folder" > "$output_file"
    for ((i=1; i<=max_depth; i++)); do
        echo -n ",Subfolder $i" >> "$output_file"
    done
    echo ",File Name" >> "$output_file"

    local hidden_flag=""
    [[ "$include_hidden" != "s" ]] && hidden_flag="-not -path '*/.*'"

    local main_folder=${base_dir:t}
    local last_folder=""

    eval find "$base_dir" -type f $hidden_flag ${extensions:+-name \*${(j: -o -name \*:)extensions}} | sort | while read -r file; do
        local rel_path=${file#$base_dir/}
        local parts=(${(s:/:)rel_path})
        local file_name=${parts[-1]}
        local subfolders=(${parts[1,-2]})
        local current_folder="${subfolders[*]}"

        # Aggiungi una riga vuota se cambia la cartella
        if [[ "$current_folder" != "$last_folder" && -n "$last_folder" ]]; then
            echo >> "$output_file"
        fi

        echo -n "$main_folder" >> "$output_file"
        for ((i=1; i<=max_depth; i++)); do
            echo -n ",${subfolders[$i]:-}" >> "$output_file"
        done
        echo ",$file_name" >> "$output_file"

        last_folder="$current_folder"
    done
}

echo "Vuoi creare il file CSV nella cartella corrente? (s/n)"
read answer
if [[ "$answer" == "s" ]]; then
    base_dir="$PWD"
else
    echo "Inserisci il percorso della cartella (lascia vuoto per usare la cartella corrente):"
    read folder_path
    base_dir=${folder_path:-$PWD}
fi

echo "Inserisci le estensioni dei file da filtrare (es. .jpg .mov), o lascia vuoto per includere tutti i file:"
read -A extensions

echo "Vuoi includere i file nascosti? (s/n)"
read include_hidden

if [[ -r "$base_dir" && -x "$base_dir" ]]; then
    create_csv "$base_dir" "${extensions[*]}" "$include_hidden"
    echo "Il file CSV con la struttura delle cartelle è stato creato: $output_file"
else
    echo "Errore: permessi insufficienti per accedere alla cartella $base_dir"
fi
