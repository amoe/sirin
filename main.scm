#! /usr/bin/env mzscheme
#lang scheme

(require "sirin.scm")

(provide main)

(define-namespace-anchor a)
(define ns (namespace-anchor->namespace a))

(define (main . args)
  (when (not (null? args))
    (for-each process args)))

(define (process path)
  (with-input-from-file
    path
    (lambda ()
      (let loop ()
        (let ((datum (read)))
          (when (not (eof-object? datum))
            (eval datum ns)
            (loop)))))))
                         
   
;;   (let loop ([l null])
;;     (let ([line (read-line p mode)])
;;       (if (eof-object? line)
;;           (reverse l)
;;           (loop (cons line l))))))

;;   (let ((form (file->value path)))
;;     (eval form ns)))
