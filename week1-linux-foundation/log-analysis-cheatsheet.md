# Log Analysis with Command-Line Tools

This document outlines a powerful one-liner command used to parse log files, count occurrences of errors, and identify the sources. This is a fundamental skill for troubleshooting and monitoring in any production environment.

## The "Magic" One-Liner

To find the IP addresses that caused the most "ERROR" entries in a log file, I used the following command chain:

```bash
grep "ERROR" app.log | awk '{print $4}' | sort | uniq -c | sort -nr
Breakdown of the Command
grep "ERROR" app.log: This command scans the app.log file and filters out only the lines that contain the string "ERROR", serving as our initial filter.

| awk '{print $4}': The resulting error lines are then piped to awk. This tool processes the text column by column and is instructed to print only the 4th column ($4), which represents the IP address in our log format.

| sort: The list of extracted IP addresses is piped to sort. This crucial step arranges the IPs alphabetically, which groups all identical IP addresses next to each other, preparing them for the next stage.

| uniq -c: The sorted list is then piped to uniq -c. The uniq command collapses the list of adjacent identical lines into a single line, and the -c flag prepends the count of occurrences.

| sort -nr: Finally, this result is piped to another sort command. The -n flag sorts the lines numerically (based on the count), and the -r flag reverses the order, ensuring that the IP with the highest error count appears at the top.
