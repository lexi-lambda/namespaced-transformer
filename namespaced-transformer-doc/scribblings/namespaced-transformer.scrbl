#lang scribble/manual

@(require (for-label namespaced-transformer
                     racket/base
                     racket/contract
                     (only-in syntax/module-reader make-meta-reader)))

@title{The @racket[#%namespaced] hook}

@defmodule[namespaced-transformer]

The @racket[#%namespaced] form adds a form of explicit identifier namespacing, designed to be used in
contexts where syntax objects must be created without lexical scope, such as when implementing
@racket[read-syntax] for a language. This is especially useful for “language extensions”, also known
as “meta languages”, such as languages created using @racket[make-meta-reader]. Since language
extensions do not have control over the lexical environment that the produced syntax objects will be
evaluated in, it is difficult to create hygienic extensions that adjust semantics. If the “host”
language provides @racket[#%namespaced], then language extensions can use it to safely hook into
the result by defining ordinary syntax transformers.

@defform[(#%namespaced module-path form)
         #:grammar ([form id (id . args)])]{
Equivalent to @racket[form], except that @racket[id]’s lexical context is adjusted to refer to an
identifier imported from @racket[module-path]. All source locations and syntax properties in
@racket[form] are preserved, and if @racket[form] is a list, then @racket[args] are passed through
entirely unmodified.}

@section{Checking if languages support @racket[#%namespaced]}

@defmodule[namespaced-transformer/info-key]

@defthing[key:supports-namespaced? any/c]{
The @racket[key:supports-namespaced?] value is an opaque key designed to be used as the first argument
to a language’s @code{get-info} procedure. A base language that provides @racket[#%namespaced] should
provide a @code{get-info} procedure that returns @racket[#t] when given
@racket[key:supports-namespaced?] as a key. See also @racket[read-language] for an example of how
@code{get-info} is used.}
