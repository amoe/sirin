#lang scheme

(define (cpspch octave pitch)
  (let ((octave-difference (- octave 8)))
    (* 440 (expt 2 (/ (+ (- pitch 9) (* 12 octave-difference)) 12)))))

