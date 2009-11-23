#! /usr/bin/env mzscheme
#lang scheme

(require "main.scm")
(apply main (vector->list (current-command-line-arguments)))
