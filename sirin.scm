#lang scheme

(require (planet schematics/schemeunit))
(require (planet schematics/schemeunit/text-ui))

(require "structures.scm")

(provide score 
         (struct-out i-statement))

(define (score . args)
  (for-each
    (lambda (datum)
      (display datum)
      (newline))
    args))

; Private functions for interactive use
(define (generate-points size n-points)
  (let loop ((n-left n-points))
    (if (zero? n-left)
        '()
        (cons (random (round (/ size n-points)))
              (loop (- n-left 1))))))

(define (format-table table)
  (let-values (((all-but-last last) (split-at-right table 1)))
    (string-join
      (map (lambda (n)
             (real->decimal-string n 2))
           (append (flatten all-but-last)
                   (list (car (first last)))))
      ", ")))

(define (generate-table size n-points)
  (let ((lengths (generate-points size (- n-points 2))))
    (let ((end-length (- size (apply + lengths))))
      (let ((points (build-list (- n-points 1) (lambda args (random)))))
        (map cons
             (append points (list (first points)))
             (append lengths (list end-length #f)))))))

(define/provide-test-suite *test-suite*
  (check = 1 1))
