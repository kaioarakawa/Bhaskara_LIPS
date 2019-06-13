#lang racket/gui

(define (delta a b c)
  (- (expt b 2) (* a c 4)))



(define (raizes a b delt)
  (list (/ (- (sqrt delt) b) (* a 2))
	(/ (- (+ (sqrt delt) b)) (* a 2))))

(define (eixox a b)
     (/
        (* -1 b) (* 2 a)
     )
 )

(define (eixoy a b c)
     (/
        (* -1 (delta a b c )) (* 4 a)
     )
 )


(define (bhaskara a b c)
  (unless (< (delta a b c) 0)
    (raizes a b (delta a b c))))

(require db)
(define pgc
(mysql-connect #:user "root"      
           #:database "dr"
           #:server "localhost"  )
 )

(require 2htdp/batch-io) 
(define ff (new frame%
                [label "Adjust widths"]
                [height 200]
                [width 400]))
(new message% [parent ff][label "testing"])
(define a (new text-field% [label "A"] [parent ff] [min-width  64] ))
(define b (new text-field% [label "B"] [parent ff] [min-width  64]))
(define c (new text-field% [label "C"] [parent ff] [min-width  64]))

(new button% [parent ff]
             [label "Calcular"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                  (write-file "teste.txt" (~a "\nA " (string->number (send a get-value))
                                             "\nB " (string->number (send b get-value))
                                             "\nC " (string->number (send c get-value))
                                           "\neixo X  "(eixox (string->number (send a get-value)) (string->number (send b get-value)))
                                           "\neixo Y " (eixoy (string->number (send a get-value)) (string->number (send b get-value)) (string->number (send c get-value)))
                                           "\nBhaskara "( bhaskara (string->number (send a get-value)) (string->number (send b get-value)) (string->number (send c get-value)))))
                  (display (~a "\neixo X  "))
                  (display (eixox(string->number (send a get-value))   (string->number (send b get-value))))
                  (display (~a "\neixo Y  "))
                  (display (eixoy (string->number (send a get-value))   (string->number (send b get-value)) (string->number (send c get-value))))    
                  (display (~a "\nbhaskara  "))
                  (display( bhaskara (string->number (send a get-value))   (string->number (send b get-value)) (string->number (send c get-value)))))      
                       ])





(send ff show #t)
