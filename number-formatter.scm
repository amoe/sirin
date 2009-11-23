#lang scheme

(require (planet schematics/schemeunit))
(require (planet schematics/schemeunit/text-ui))

(require srfi/13)
(require srfi/14)

(provide format-real)

(define (format-real n digits)
  (let ((str (real->decimal-string n digits)))
    (let ((point-index (string-index str #\.)))
      (let ((first-part  (string-take str point-index))
            (second-part (string-drop str (+ point-index 1))))
        (let ((minimal-ending (string-trim-right second-part #\0)))
          (if (string-null? minimal-ending)
              first-part
              (string-append first-part "." minimal-ending)))))))
          

(define/provide-test-suite *test-suite*
  (check-equal? (format-real 1 2) "1")
  (check-equal? (format-real 0 2) "0")
  (check-equal? (format-real -1 2) "-1")
  (check-equal? (format-real 1.1 2) "1.1")
  (check-equal? (format-real 1.12 2) "1.12")
  (check-equal? (format-real 1.123 2) "1.12")
  (check-equal? (format-real 1.126 2) "1.13")
  (check-equal? (format-real 1.125 2) "1.12"))   ; dutch rounding
