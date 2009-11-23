#lang scheme

(require "number-formatter.scm")

(provide (struct-out t-statement)
         (struct-out i-statement)
         (struct-out note-object)
         (struct-out sim-object))

; We model the 't' statement in the simplest way possible.  Since
; structs cannot take rest arguments like functions, it is necessary
; to store rest arguments as an explicit list.  We don't allow any
; structure within the points list, for instance.  A higher level
; layer might choose to represent the graph as a list of (X, Y) cons
; cells: but we choose the closest representation to that used by
; Csound itself, even requiring the redundant zero for P1.

(define (t-statement-custom-write struct port mode)
  ((if mode write display)
    (string-append "t "
                   (string-join
                     (map (lambda (val) (format "~a" val))
                          (append
                            (list (t-statement-zero struct)
                                  (t-statement-initial-tempo struct))
                            (t-statement-tempo-points struct)))
                     (string #\space)))
    port))

(define-struct t-statement
  (zero
   initial-tempo
   tempo-points)
  #:property prop:custom-write t-statement-custom-write)

; The 'i' statement.  Please note that the last argument MUST be a
; list, even an empty one; otherwise structures will not print at all.
; It might be worth defining a guard procedure to enforce this
; condition.

(define (i-statement-custom-write struct port mode)
  (when (not (i-statement-start struct))
    (error 'i-statement-custom-write
           "can't display an i statement with no start time"))

  ((if mode write display)
    (string-append "i "
                   (string-join
                     (map (lambda (val) (format "~a" val))
                          (append
                            (list (i-statement-instrument-number struct)
                                  (format-real (i-statement-start struct) 2)
                                  (i-statement-duration struct))
                            (map (lambda (p) (format-real p 2))
                                 (i-statement-p-fields struct))))
                     (string #\space)))
    port))

(define-struct i-statement
  (instrument-number
   start
   duration
   p-fields)
  #:property prop:custom-write i-statement-custom-write)


; The NOTE structure.  Just a tag, really.
(define-struct note-object (pitch))

(define-struct sim-object (events))
