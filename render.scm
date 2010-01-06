#! /usr/bin/env mzscheme
#lang scheme

(require scheme/system)
(require utils/koizumi)

; sirin-render - render a sirin piece

(define *sirin-path* "/home/amoe/code/sirin/test.scm")

(define (main . args)
  (for-each render args))

(define (render path)
  (system (format "mzscheme ~a ~a > ~a"
                  *sirin-path* path (score-form path)))
  (csound/checked (wave-form path) (orchestra-form path) (score-form path))
  (system (format "mplayer ~a"
                  (wave-form path))))

(define (system/checked cmd)
  (let ((worked? (system cmd)))
    (when (not worked?) (error "command broke"))))

(define (csound/checked output orchestra score)
  (let ((csound-output (backticks
                         (format "csound -ndo ~a ~a ~a 2>&1"
                                 output orchestra score))))
    (let ((errors (filter (curry regexp-match #px"\\d+ errors in performance")
                    csound-output)))
      (when (not (= (length errors) 1))
        (error "malformed error list from csound: ~s" errors))
      (let ((error-string (regexp-match #px"^\\d+" (first errors))))
        (when (and error-string (not (string=? (first error-string) "0")))
          (printf "Full Csound output:\n~a\n" (string-join csound-output "\n"))
          (raise-user-error "errors during csound performance: " error-string))))))
                  
(define (wave-form path)
  (path-replace-suffix path ".wav"))

(define (score-form path)
  (path-replace-suffix path ".sco"))

(define (orchestra-form path)
  (path-replace-suffix path ".orc"))

(apply main (vector->list (current-command-line-arguments)))
