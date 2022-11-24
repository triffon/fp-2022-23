#lang racket

(define row-count length)

(define get-first-row car)

(define (column-count matrix)
  (length (get-first-row matrix)))