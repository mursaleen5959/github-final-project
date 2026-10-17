#!/usr/bin/env bash
# Simple Interest Calculator
# Formula: Simple Interest = (Principal * Rate * Time) / 100

set -euo pipefail

read_nonnegative_number() {
    local prompt="$1" value
    while true; do
        read -r -p "$prompt" value || exit 1
        if [[ "$value" =~ ^([0-9]+([.][0-9]*)?|[.][0-9]+)$ ]]; then
            REPLY="$value"
            return
        fi
        printf 'Invalid input. Enter a non-negative number (e.g., 1000 or 5.5).\n' >&2
    done
}

printf '%s\n' '=== Simple Interest Calculator ==='
read_nonnegative_number 'Enter principal amount: '
principal="$REPLY"
read_nonnegative_number 'Enter annual interest rate (%): '
rate="$REPLY"
read_nonnegative_number 'Enter time period (years): '
time="$REPLY"

awk -v p="$principal" -v r="$rate" -v t="$time" 'BEGIN {
    interest = (p * r * t) / 100
    printf "\nSimple Interest: %.2f\n", interest
    printf "Total Amount:    %.2f\n", p + interest
}'
