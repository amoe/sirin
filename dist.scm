#! /usr/bin/env mzscheme
#lang scheme

(require "../lib/sirin/main.scm")
(apply main (vector->list (current-command-line-arguments)))
