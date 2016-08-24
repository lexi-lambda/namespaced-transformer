#lang racket/base

(require (for-syntax racket/base
                     syntax/parse))

(provide #%namespaced)

(define-syntax #%namespaced
  (syntax-parser
    [(_ module-path:expr id:id)
     (syntax-local-introduce
      (syntax-local-lift-require
       (syntax-local-introduce #'module-path)
       (syntax-local-introduce #'id)))]
    [(_ module-path:expr {~and form (id:id . args)})
     (datum->syntax #'form
                    (cons (syntax-local-introduce
                           (syntax-local-lift-require
                            (syntax-local-introduce #'module-path)
                            (syntax-local-introduce #'id)))
                          #'args)
                    #'form #'form)]))
