#lang scheme

; test file for fuckin' around
; It's not a good idea to abuse the structures for notes at uncertain times.
; Better to define a generalized template struct that is translated into one or
; more i-statements by the score processor.

(require "structures.scm")

(define (score . lst)
  (for-each (lambda (val) (display val) (newline)) lst))

(define (tempo bpm-value)
  (make-t-statement 0 bpm-value '()))

(define (instrument)
  (make-i-statement 1 0 2 '()))
