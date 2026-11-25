#!/bin/sh
set -eu
cd "$(dirname "$0")/.."

mkdir -p _site/research
cp -R css fig fonts _site/
cp CNAME 404.html _site/

render() {
    section=$1
    title=$2
    description=$3
    path=$4
    root=$5
    destination=$6
    home_current=''
    research_current=''
    case "$section" in
        home) home_current=' aria-current="page"' ;;
        research) research_current=' aria-current="page"' ;;
    esac

    sed -e "s|{{TITLE}}|$title|g" \
        -e "s|{{DESCRIPTION}}|$description|g" \
        -e "s|{{PATH}}|$path|g" \
        -e "s|{{ROOT}}|$root|g" \
        -e "s|{{HOME_CURRENT}}|$home_current|g" \
        -e "s|{{RESEARCH_CURRENT}}|$research_current|g" \
        -e "/{{CONTENT}}/r sections/$section.html" \
        -e '/{{CONTENT}}/d' index.html > "$destination"
}

render home 'Yichuan Zhang (张艺川)' \
    'Yichuan Zhang is an assistant professor at Jinan University. Her research focuses on the digital economy and innovation management.' \
    '/' './' '_site/index.html'
render research 'Research – Yichuan Zhang (张艺川)' \
    'Publications and working papers by Yichuan Zhang.' \
    '/research/' '../' '_site/research/index.html'
