#!/bin/bash

# Zapytanie SQL
QUERY="SELECT
	db_name,
	table_name,
	column_name,
	hist_type,
	hex(histogram),
	decode_histogram(hist_type, histogram)
FROM
	mysql.column_stats
WHERE
	db_name = 'ids'"

# Wykonanie zapytania SQL i przetwarzanie wyników
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "$QUERY" -B | tail -n +2 | while IFS=$'\t' read -r db_name table_name column_name hist_type histogram decoded_histogram; do
    # Wyświetlanie informacji o histogramie
    echo "Database: $db_name Table: $table_name Column: $column_name Histogram Type: $hist_type Histogram (Hex): $histogram Decoded Histogram: $decoded_histogram"

    mkdir -p "./tmp/analysis_result/${db_name}/${table_name}"
    mkdir -p "./tmp/images/histogram/${db_name}/${table_name}"

    QUERY="SELECT ${column_name} FROM ${db_name}.${table_name} PROCEDURE ANALYSE()" 
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "$QUERY" -H > "./tmp/analysis_result/${db_name}/${table_name}/${column_name}.html"

    # Sprawdzenie, czy histogram jest niepusty
    if [[ -n "$histogram" ]]; then
        # Przetwarzanie histogramu i wyświetlanie liczby wystąpień

        declare -A counts

        while IFS=',' read -r value; do
            ((counts[$value]++))
            echo "Value '$value' Count: ${counts[$value]}"
        done <<< "$decoded_histogram"

        echo "$decoded_histogram" | tr ',' '\n' | uniq -c > histogram_data_sorted.txt

        # Przygotowanie danych dla gnuplot
        echo "set terminal png size 1600,1200" > histogram.gnuplot
        echo "set output './tmp/images/histogram/${db_name}/${table_name}/${column_name}.png'" >> histogram.gnuplot
        echo "set title 'Histogram for $db_name.$table_name.$column_name'" >> histogram.gnuplot
        echo "set xlabel 'Value'" >> histogram.gnuplot
        echo "set ylabel 'Frequency'" >> histogram.gnuplot
        echo "set boxwidth 0.1 relative" >> histogram.gnuplot
        echo "set style fill solid" >> histogram.gnuplot
        echo "set xtics rotate by -45" >> histogram.gnuplot
        echo "plot 'histogram_data_sorted.txt' using 2:1 with boxes notitle" >> histogram.gnuplot

        # Przetwarzanie danych histogramu dla gnuplot
        for value in "${!counts[@]}"; do
            echo "$value ${counts[$value]}"
        done >> histogram.gnuplot

        # Poprawne zakończenie danych dla gnuplot
        echo "e" >> histogram.gnuplot  

        # Wygenerowanie obrazka histogramu przy użyciu gnuplot
        gnuplot histogram.gnuplot

        # Wyświetlenie ścieżki do obrazka histogramu
        echo "Histogram image saved as histogram_${db_name}_${table_name}_${column_name}.png"
    fi

    echo "-----------------------------------"
done