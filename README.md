[![Actions Status](https://github.com/frithnanth/raku-Math-Libgsl-Permutation/workflows/test/badge.svg)](https://github.com/frithnanth/raku-Math-Libgsl-Permutation/actions)

NAME
====

Math::Libgsl::Permutation - An interface to libgsl, the Gnu Scientific Library - Permutations.

SYNOPSIS
========

```raku
use Math::Libgsl::Raw::Permutation :ALL;

use Math::Libgsl::Permutation;
```

DESCRIPTION
===========

Math::Libgsl::Permutation provides an interface to the permutation functions of libgsl, the GNU Scientific Library.

This package provides both the low-level interface to the C library (Raw) and a more comfortable interface layer for the Raku programmer.

### new(:$elems!)

### new($elems!)

The constructor accepts one parameter: the number of elements in the permutation; it can be passed as a Pair or as a single value. The permutation object is already initialized to the identity (0, 1, 2 … $elems - 1).

All the following methods *throw* on error if they return **self**, otherwise they *fail* on error.

### init()

This method initialize the permutation object to the identity and returns **self**.

### copy($src! where * ~~ Math::Libgsl::Permutation)

This method copies the permutation **$src** into the current permutation object and returns **self**.

### get(Int $elem! --> Int)

This method returns the permutation value at position **$elem**.

### all(--> Seq)

This method returns a Seq of all the elements of the current permutation.

### swap(Int $elem1!, Int $elem2!)

This method swamps two elements of the current permutation object and returns **self**.

### size(--> Int)

This method returns the size of the current permutation object.

### is-valid(--> Bool)

This method checks whether the current permutation is valid: the n elements should contain each of the numbers 0 to n - 1 once and only once.

### reverse()

This method reverses the order of the elements of the current permutation object.

### inverse($dst! where * ~~ Math::Libgsl::Permutation)

This method computes the inverse of the current permutation and stores the result into **$dst**.

### next()

### prev()

These functions advance or step backwards the permutation and return **self**, useful for method chaining.

### bnext(--> Bool)

### bprev(--> Bool)

These functions advance or step backwards the permutation and return a Bool: **True** if successful or **False** if there's no more permutation to produce.

### permute(@data!, Int $stride! --> List)

This method applies the current permutation to the **@data** array with stride **$stride**.

### permute-inverse(@data!, Int $stride! --> List)

This method applies the inverse of the current permutation to the **@data** array with stride **$stride**.

### permute-complex64(Complex @data!, Int $stride! --> List)

This method applies the current permutation to the **@data** array array of Complex with stride **$stride**.

### permute-complex64-inverse(Complex @data!, Int $stride! --> List)

This method applies the inverse of the current permutation to the **@data** array of Complex with stride **$stride**.

### permute-complex32(Complex @data!, Int $stride! --> List)

This method applies the current permutation to the **@data** array array of Complex with stride **$stride**, trating the numbers as single precision floats.

### permute-complex32-inverse(Complex @data!, Int $stride! --> List)

This method applies the inverse of the current permutation to the **@data** array of Complex with stride **$stride**, trating the numbers as single precision floats.

### permute-vector(Math::Libgsl::Vector $v)

This method applies the permutation to a Vector object and returns the Vector object itself. As in the case of the Vector object, this method is available for all the supported data type, so we have

  * permute-vector-num32

  * permute-vector-int32

  * permute-vector-uint32

…and so on.

### permute-vector-inv(Math::Libgsl::Vector $v)

This method applies the inverse permutation to a Vector object and returns the Vector object itself. As in the case of the Vector object, this method is available for all the supported data type, so we have

  * permute-vector-inv-num32

  * permute-vector-inv-int32

  * permute-vector-inv-uint32

…and so on.

### permute-matrix(Math::Libgsl::Matrix $m) This method applies the permutation to a Matrix object and returns the Matrix object itself. As in the case of the Matrix object, this method is available for all the supported data type, so we have

  * permute-matrix-num32

  * permute-matrix-int32

  * permute-matrix-uint32

…and so on.

### write(Str $filename! --> Int)

This method writes the permutation data to a file.

### read(Str $filename! --> Int)

This method reads the permutation data from a file. The permutation must be of the same size of the one to be read.

### fprintf(Str $filename!, Str $format! --> Int)

This method writes the permutation data to a file, using the format specifier.

### fscanf(Str $filename!)

This method reads the permutation data from a file. The permutation must be of the same size of the one to be read.

### multiply($dst! where * ~~ Math::Libgsl::Permutation, $p2! where * ~~ Math::Libgsl::Permutation)

This method combines the current permutation with the permutation **$p2**, stores the result into **$dst** and returns **self**.

### to-canonical($dst! where * ~~ Math::Libgsl::Permutation)

This method computes the canonical form of the current permutation, stores the result into **$dst** and returns **self**.

### to-linear($dst! where * ~~ Math::Libgsl::Permutation)

This method computes the linear form of the current permutation, stores the result into **$dst** and returns **self**.

### inversions(--> Int)

This method counts the number of inversions in the current permutation.

### linear-cycles(--> Int)

This method counts the number of cycles in the current permutation given in linear form.

### canonical-cycles(--> Int)

This method counts the number of cycles in the current permutation given in canonical form.

C Library Documentation
=======================

For more details on libgsl see [https://www.gnu.org/software/gsl/](https://www.gnu.org/software/gsl/). The excellent C Library manual is available here [https://www.gnu.org/software/gsl/doc/html/index.html](https://www.gnu.org/software/gsl/doc/html/index.html), or here [https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf](https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf) in PDF format.

Prerequisites
=============

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

Debian Linux and Ubuntu 20.04+
------------------------------

    sudo apt install libgsl23 libgsl-dev libgslcblas0

That command will install libgslcblas0 as well, since it's used by the GSL.

Ubuntu 18.04
------------

libgsl23 and libgslcblas0 have a missing symbol on Ubuntu 18.04. I solved the issue installing the Debian Buster version of those three libraries:

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb)

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb)

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb)

Installation
============

To install it using zef (a module management tool):

    $ zef install Math::Libgsl::Permutation

AUTHOR
======

Fernando Santagata <nando.santagata@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2020 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

