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

render home '张艺川' \
    '张艺川，暨南大学产业经济研究院助理教授，研究方向为数字经济和创新管理。' \
    '/' './' '_site/index.html'
render research '研究 – 张艺川' \
    '张艺川已发表的论文及工作论文。' \
    '/research/' '../' '_site/research/index.html'
