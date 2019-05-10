#!/bin/bash

type nvim > /dev/null 2>&1 && nvim +PlugUpgrade +PlugUpdate +PlugClean +qall ||
    vim +PlugUpgrade +PlugUpdate +PlugClean +qall
