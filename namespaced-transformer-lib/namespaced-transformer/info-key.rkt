#lang racket/base

(provide key:supports-namespaced?)

(define key:supports-namespaced?
  (let ()
    (struct supports-namespaced? ()
      #:reflection-name 'get-info-key:supports-namespaced?)
    (supports-namespaced?)))
