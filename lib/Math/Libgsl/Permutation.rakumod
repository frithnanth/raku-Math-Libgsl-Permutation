use v6;

unit class Math::Libgsl::Permutation:ver<0.0.5>:auth<cpan:FRITH>;

use Math::Libgsl::Raw::Permutation :ALL;
use Math::Libgsl::Vector;
use Math::Libgsl::Vector::Num32;
use Math::Libgsl::Vector::Int8;
use Math::Libgsl::Vector::Int16;
use Math::Libgsl::Vector::Int32;
use Math::Libgsl::Vector::Int64;
use Math::Libgsl::Vector::UInt8;
use Math::Libgsl::Vector::UInt16;
use Math::Libgsl::Vector::UInt32;
use Math::Libgsl::Vector::UInt64;
use Math::Libgsl::Vector::Complex64;
use Math::Libgsl::Vector::Complex32;
use Math::Libgsl::Matrix;
use Math::Libgsl::Matrix::Num32;
use Math::Libgsl::Matrix::Int8;
use Math::Libgsl::Matrix::Int16;
use Math::Libgsl::Matrix::Int32;
use Math::Libgsl::Matrix::Int64;
use Math::Libgsl::Matrix::UInt8;
use Math::Libgsl::Matrix::UInt16;
use Math::Libgsl::Matrix::UInt32;
use Math::Libgsl::Matrix::UInt64;
use Math::Libgsl::Matrix::Complex64;
use Math::Libgsl::Matrix::Complex32;
use Math::Libgsl::Exception;
use Math::Libgsl::Constants;
use NativeCall;

has gsl_permutation $.p;

multi method new(Int $elems!) { self.bless(:$elems) }

multi method new(Int :$elems!) { self.bless(:$elems) }

submethod BUILD(:$elems!) { $!p = gsl_permutation_calloc($elems) }

submethod DESTROY { gsl_permutation_free($!p) }

method init { gsl_permutation_init($!p); self }

method copy($src! where * ~~ Math::Libgsl::Permutation) { gsl_permutation_memcpy($!p, $src.p); self }

method get(Int $elem! --> Int)
{
  fail X::Libgsl.new: errno => GSL_EINVAL, error => 'Index out of range' if $elem > $!p.size - 1;
  gsl_permutation_get($!p, $elem)
}

method all(--> Seq) { $!p.data[^$.size] }

method swap(Int $elem1!, Int $elem2!)
{
  fail X::Libgsl.new: errno => GSL_EINVAL, error => 'Index out of range' if $!p.size ≤ $elem1|$elem2;
  my $ret = gsl_permutation_swap($!p, $elem1, $elem2);
  fail X::Libgsl.new: errno => $ret, error => "Can't get next permutation" if $ret ≠ GSL_SUCCESS;
  self
}

method size(--> Int) { gsl_permutation_size($!p) }

method is-valid(--> Bool) { gsl_permutation_valid($!p) == GSL_SUCCESS ?? True !! False }

method reverse { gsl_permutation_reverse($!p); self }

method inverse($dst! where * ~~ Math::Libgsl::Permutation) { gsl_permutation_inverse($dst.p, $!p); self }

method next
{
  my $ret = gsl_permutation_next($!p);
  fail X::Libgsl.new: errno => $ret, error => "Can't get next permutation" if $ret ≠ GSL_SUCCESS;
  self
}

method prev
{
  my $ret = gsl_permutation_prev($!p);
  fail X::Libgsl.new: errno => $ret, error => "Can't get previous permutation" if $ret ≠ GSL_SUCCESS;
  self
}

method bnext(--> Bool) { gsl_permutation_next($!p) == GSL_SUCCESS ?? True !! False }

method bprev(--> Bool) { gsl_permutation_prev($!p) == GSL_SUCCESS ?? True !! False }

method permute(@data!, Int $stride! --> List)
{
  my CArray[num64] $data .= new: @data».Num;
  my $ret = gsl_permute($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-inverse(@data!, Int $stride! --> List)
{
  my CArray[num64] $data .= new: @data».Num;
  my $ret = gsl_permute_inverse($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute_inverse" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-num32(@data!, Int $stride! --> List)
{
  my CArray[num32] $data .= new: @data».Num;
  my $ret = gsl_permute_float($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-num32-inverse(@data!, Int $stride! --> List)
{
  my CArray[num32] $data .= new: @data».Num;
  my $ret = gsl_permute_float_inverse($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute_inverse" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-int32(@data!, Int $stride! --> List)
{
  my CArray[int32] $data .= new: @data».Num;
  my $ret = gsl_permute_int($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-int32-inverse(@data!, Int $stride! --> List)
{
  my CArray[int32] $data .= new: @data».Num;
  my $ret = gsl_permute_int_inverse($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute_inverse" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-uint32(@data!, Int $stride! --> List)
{
  my CArray[uint32] $data .= new: @data».Num;
  my $ret = gsl_permute_uint($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-uint32-inverse(@data!, Int $stride! --> List)
{
  my CArray[uint32] $data .= new: @data».Num;
  my $ret = gsl_permute_uint_inverse($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute_inverse" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-int64(@data!, Int $stride! --> List)
{
  my CArray[int64] $data .= new: @data».Num;
  my $ret = gsl_permute_long($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-int64-inverse(@data!, Int $stride! --> List)
{
  my CArray[int64] $data .= new: @data».Num;
  my $ret = gsl_permute_long_inverse($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute_inverse" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-uint64(@data!, Int $stride! --> List)
{
  my CArray[uint64] $data .= new: @data».Num;
  my $ret = gsl_permute_ulong($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-uint64-inverse(@data!, Int $stride! --> List)
{
  my CArray[uint64] $data .= new: @data».Num;
  my $ret = gsl_permute_ulong_inverse($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute_inverse" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-int16(@data!, Int $stride! --> List)
{
  my CArray[int16] $data .= new: @data».Num;
  my $ret = gsl_permute_short($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-int16-inverse(@data!, Int $stride! --> List)
{
  my CArray[int16] $data .= new: @data».Num;
  my $ret = gsl_permute_short_inverse($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute_inverse" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-uint16(@data!, Int $stride! --> List)
{
  my CArray[uint16] $data .= new: @data».Num;
  my $ret = gsl_permute_ushort($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-uint16-inverse(@data!, Int $stride! --> List)
{
  my CArray[uint16] $data .= new: @data».Num;
  my $ret = gsl_permute_ushort_inverse($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute_inverse" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-int8(@data!, Int $stride! --> List)
{
  my CArray[int8] $data .= new: @data».Num;
  my $ret = gsl_permute_char($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-int8-inverse(@data!, Int $stride! --> List)
{
  my CArray[int8] $data .= new: @data».Num;
  my $ret = gsl_permute_char_inverse($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute_inverse" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-uint8(@data!, Int $stride! --> List)
{
  my CArray[uint8] $data .= new: @data».Num;
  my $ret = gsl_permute_uchar($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-uint8-inverse(@data!, Int $stride! --> List)
{
  my CArray[uint8] $data .= new: @data».Num;
  my $ret = gsl_permute_uchar_inverse($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute_inverse" if $ret ≠ GSL_SUCCESS;
  $data.list
}

method permute-complex64(Complex @data!, Int $stride! --> List)
{
  my CArray[num64] $data .= new: @data.map(|*)».reals.List.flat;
  my $ret = gsl_permute_complex($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute_complex" if $ret ≠ GSL_SUCCESS;
  $data.map(-> $r, $i { Complex.new($r, $i) }).list
}

method permute-complex64-inverse(Complex @data!, Int $stride! --> List)
{
  my CArray[num64] $data .= new: @data.map(|*)».reals.List.flat;
  my $ret = gsl_permute_complex_inverse($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute_complex_inverse" if $ret ≠ GSL_SUCCESS;
  $data.map(-> $r, $i { Complex.new($r, $i) }).list
}

method permute-complex32(Complex @data!, Int $stride! --> List)
{
  my CArray[num32] $data .= new: @data.map(|*)».reals.List.flat;
  my $ret = gsl_permute_complex_float($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute_complex_float" if $ret ≠ GSL_SUCCESS;
  $data.map(-> $r, $i { Complex.new($r, $i) }).list
}

method permute-complex32-inverse(Complex @data!, Int $stride! --> List)
{
  my CArray[num32] $data .= new: @data.map(|*)».reals.List.flat;
  my $ret = gsl_permute_complex_float_inverse($!p.data, $data, $stride, @data.elems);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute_complex_float_inverse" if $ret ≠ GSL_SUCCESS;
  $data.map(-> $r, $i { Complex.new($r, $i) }).list
}

method permute-vector(Math::Libgsl::Vector $v)
{
  my $ret = gsl_permute_vector($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-num32(Math::Libgsl::Vector::Num32 $v)
{
  my $ret = gsl_permute_vector_float($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-int32(Math::Libgsl::Vector::Int32 $v)
{
  my $ret = gsl_permute_vector_int($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-uint32(Math::Libgsl::Vector::UInt32 $v)
{
  my $ret = gsl_permute_vector_uint($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-int64(Math::Libgsl::Vector::Int64 $v)
{
  my $ret = gsl_permute_vector_long($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-uint64(Math::Libgsl::Vector::UInt64 $v)
{
  my $ret = gsl_permute_vector_ulong($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-int16(Math::Libgsl::Vector::Int16 $v)
{
  my $ret = gsl_permute_vector_short($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-uint16(Math::Libgsl::Vector::UInt16 $v)
{
  my $ret = gsl_permute_vector_ushort($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-int8(Math::Libgsl::Vector::Int8 $v)
{
  my $ret = gsl_permute_vector_char($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-uint8(Math::Libgsl::Vector::UInt8 $v)
{
  my $ret = gsl_permute_vector_uchar($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-complex64(Math::Libgsl::Vector::Complex64 $v)
{
  my $ret = gsl_permute_vector_complex($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-complex32(Math::Libgsl::Vector::Complex32 $v)
{
  my $ret = gsl_permute_vector_complex_float($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}

method permute-vector-inv(Math::Libgsl::Vector $v)
{
  my $ret = gsl_permute_vector_inverse($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't inverse permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-inv-num32(Math::Libgsl::Vector::Num32 $v)
{
  my $ret = gsl_permute_vector_float_inverse($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't inverse permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-inv-int32(Math::Libgsl::Vector::Int32 $v)
{
  my $ret = gsl_permute_vector_int_inverse($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't inverse permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-inv-uint32(Math::Libgsl::Vector::UInt32 $v)
{
  my $ret = gsl_permute_vector_uint_inverse($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't inverse permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-inv-int64(Math::Libgsl::Vector::Int64 $v)
{
  my $ret = gsl_permute_vector_long_inverse($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't inverse permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-inv-uint64(Math::Libgsl::Vector::UInt64 $v)
{
  my $ret = gsl_permute_vector_ulong_inverse($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't inverse permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-inv-int16(Math::Libgsl::Vector::Int16 $v)
{
  my $ret = gsl_permute_vector_short_inverse($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't inverse permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-inv-uint16(Math::Libgsl::Vector::UInt16 $v)
{
  my $ret = gsl_permute_vector_ushort_inverse($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't inverse permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-inv-int8(Math::Libgsl::Vector::Int8 $v)
{
  my $ret = gsl_permute_vector_char_inverse($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't inverse permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-inv-uint8(Math::Libgsl::Vector::UInt8 $v)
{
  my $ret = gsl_permute_vector_uchar_inverse($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't inverse permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-inv-complex64(Math::Libgsl::Vector::Complex64 $v)
{
  my $ret = gsl_permute_vector_complex_inverse($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't inverse permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}
method permute-vector-inv-complex32(Math::Libgsl::Vector::Complex32 $v)
{
  my $ret = gsl_permute_vector_complex_float_inverse($!p, $v.vector);
  fail X::Libgsl.new: errno => $ret, error => "Can't inverse permute the vector" if $ret ≠ GSL_SUCCESS;
  $v
}

method permute-matrix(Math::Libgsl::Matrix $m)
{
  my $ret = gsl_permute_matrix($!p, $m.matrix);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the matrix" if $ret ≠ GSL_SUCCESS;
  $m
}
method permute-matrix-num32(Math::Libgsl::Matrix::Num32 $m)
{
  my $ret = gsl_permute_matrix_float($!p, $m.matrix);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the matrix" if $ret ≠ GSL_SUCCESS;
  $m
}
method permute-matrix-int32(Math::Libgsl::Matrix::Int32 $m)
{
  my $ret = gsl_permute_matrix_int($!p, $m.matrix);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the matrix" if $ret ≠ GSL_SUCCESS;
  $m
}
method permute-matrix-uint32(Math::Libgsl::Matrix::UInt32 $m)
{
  my $ret = gsl_permute_matrix_uint($!p, $m.matrix);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the matrix" if $ret ≠ GSL_SUCCESS;
  $m
}
method permute-matrix-int64(Math::Libgsl::Matrix::Int64 $m)
{
  my $ret = gsl_permute_matrix_long($!p, $m.matrix);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the matrix" if $ret ≠ GSL_SUCCESS;
  $m
}
method permute-matrix-uint64(Math::Libgsl::Matrix::UInt64 $m)
{
  my $ret = gsl_permute_matrix_ulong($!p, $m.matrix);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the matrix" if $ret ≠ GSL_SUCCESS;
  $m
}
method permute-matrix-int16(Math::Libgsl::Matrix::Int16 $m)
{
  my $ret = gsl_permute_matrix_short($!p, $m.matrix);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the matrix" if $ret ≠ GSL_SUCCESS;
  $m
}
method permute-matrix-uint16(Math::Libgsl::Matrix::UInt16 $m)
{
  my $ret = gsl_permute_matrix_ushort($!p, $m.matrix);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the matrix" if $ret ≠ GSL_SUCCESS;
  $m
}
method permute-matrix-int8(Math::Libgsl::Matrix::Int8 $m)
{
  my $ret = gsl_permute_matrix_char($!p, $m.matrix);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the matrix" if $ret ≠ GSL_SUCCESS;
  $m
}
method permute-matrix-uint8(Math::Libgsl::Matrix::UInt8 $m)
{
  my $ret = gsl_permute_matrix_uchar($!p, $m.matrix);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the matrix" if $ret ≠ GSL_SUCCESS;
  $m
}
method permute-matrix-complex64(Math::Libgsl::Matrix::Complex64 $m)
{
  my $ret = gsl_permute_matrix_complex($!p, $m.matrix);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the matrix" if $ret ≠ GSL_SUCCESS;
  $m
}
method permute-matrix-complex32(Math::Libgsl::Matrix::Complex32 $m)
{
  my $ret = gsl_permute_matrix_complex_float($!p, $m.matrix);
  fail X::Libgsl.new: errno => $ret, error => "Can't permute the matrix" if $ret ≠ GSL_SUCCESS;
  $m
}

method write(Str $filename! --> Int)
{
  my $ret = mgsl_permutation_fwrite($filename, $!p);
  fail X::Libgsl.new: errno => $ret, error => "Can't write to file" if $ret ≠ GSL_SUCCESS;
  $ret;
}

method read(Str $filename! --> Int)
{
  my $ret = mgsl_permutation_fread($filename, $!p);
  fail X::Libgsl.new: errno => $ret, error => "Can't read from file" if $ret ≠ GSL_SUCCESS;
  $ret;
}

method fprintf(Str $filename!, Str $format! --> Int)
{
  my $ret = mgsl_permutation_fprintf($filename, $!p, $format);
  fail X::Libgsl.new: errno => $ret, error => "Can't fprintf to file" if $ret ≠ GSL_SUCCESS;
  $ret;
}

method fscanf(Str $filename! --> Int)
{
  my $ret = mgsl_permutation_fscanf($filename, $!p);
  fail X::Libgsl.new: errno => $ret, error => "Can't fscanf from file" if $ret ≠ GSL_SUCCESS;
  $ret;
}

method multiply($dst! where * ~~ Math::Libgsl::Permutation, $p2! where * ~~ Math::Libgsl::Permutation)
{
  my $ret = gsl_permutation_mul($dst.p, $!p, $p2.p);
  fail X::Libgsl.new: errno => $ret, error => "Can't multiply" if $ret ≠ GSL_SUCCESS;
  self
}

method to-canonical($dst! where * ~~ Math::Libgsl::Permutation)
{
  my $ret = gsl_permutation_linear_to_canonical($dst.p, $!p);
  fail X::Libgsl.new: errno => $ret, error => "Can't transform to canonical" if $ret ≠ GSL_SUCCESS;
  self
}

method to-linear($dst! where * ~~ Math::Libgsl::Permutation)
{
  my $ret = gsl_permutation_canonical_to_linear($dst.p, $!p);
  fail X::Libgsl.new: errno => $ret, error => "Can't transform to linear" if $ret ≠ GSL_SUCCESS;
  self
}

method inversions(--> Int) { gsl_permutation_inversions($!p) }

method linear-cycles(--> Int) { gsl_permutation_linear_cycles($!p) }

method canonical-cycles(--> Int) { gsl_permutation_canonical_cycles($!p) }

=begin pod

[![Build Status](https://travis-ci.org/frithnanth/raku-Math-Libgsl-Permutation.svg?branch=master)](https://travis-ci.org/frithnanth/raku-Math-Libgsl-Permutation)

=head1 NAME

Math::Libgsl::Permutation - An interface to libgsl, the Gnu Scientific Library - Permutations.

=head1 SYNOPSIS

=begin code :lang<perl6>

use Math::Libgsl::Raw::Permutation :ALL;

use Math::Libgsl::Permutation;

=end code

=head1 DESCRIPTION

Math::Libgsl::Permutation provides an interface to the permutation functions of libgsl, the GNU Scientific Library.

This package provides both the low-level interface to the C library (Raw) and a more comfortable interface layer for the Raku programmer.

=head3 new(:$elems!)
=head3 new($elems!)

The constructor accepts one parameter: the number of elements in the permutation; it can be passed as a Pair or as a single value.
The permutation object is already initialized to the identity (0, 1, 2 … $elems - 1).

=head3 init()

This method initialize the permutation object to the identity and returns B<self>.

=head3 copy($src! where * ~~ Math::Libgsl::Permutation)

This method copies the permutation B<$src> into the current permutation object and returns B<self>.

=head3 get(Int $elem! --> Int)

This method returns the permutation value at position B<$elem>.

=head3 all(--> Seq)

This method returns a Seq of all the elements of the current permutation.

=head3 swap(Int $elem1!, Int $elem2!)

This method swamps two elements of the current permutation object and returns B<self>.

=head3 size(--> Int)

This method returns the size of the current permutation object.

=head3 is-valid(--> Bool)

This method checks whether the current permutation is valid: the n elements should contain each of the numbers 0 to n - 1 once and only once.

=head3 reverse()

This method reverses the order of the elements of the current permutation object.

=head3 inverse($dst! where * ~~ Math::Libgsl::Permutation)

This method computes the inverse of the current permutation and stores the result into B<$dst>.

=head3 next()
=head3 prev()

These functions advance or step backwards the permutation and return B<self>, useful for method chaining.

=head3 bnext(--> Bool)
=head3 bprev(--> Bool)

These functions advance or step backwards the permutation and return a Bool: B<True> if successful or B<False> if there's no more permutation to produce.

=head3 permute(@data!, Int $stride! --> List)

This method applies the current permutation to the B<@data> array with stride B<$stride>.

=head3 permute-inverse(@data!, Int $stride! --> List)

This method applies the inverse of the current permutation to the B<@data> array with stride B<$stride>.

=head3 permute-complex64(Complex @data!, Int $stride! --> List)

This method applies the current permutation to the B<@data> array array of Complex with stride B<$stride>.

=head3 permute-complex64-inverse(Complex @data!, Int $stride! --> List)

This method applies the inverse of the current permutation to the B<@data> array of Complex with stride B<$stride>.

=head3 permute-complex32(Complex @data!, Int $stride! --> List)

This method applies the current permutation to the B<@data> array array of Complex with stride B<$stride>, trating the numbers as single precision floats.

=head3 permute-complex32-inverse(Complex @data!, Int $stride! --> List)

This method applies the inverse of the current permutation to the B<@data> array of Complex with stride B<$stride>, trating the numbers as single precision floats.

=head3 permute-vector(Math::Libgsl::Vector $v)

This method applies the permutation to a Vector object and returns the Vector object itself.
As in the case of the Vector object, this method is available for all the supported data type, so we have

=item permute-vector-num32
=item permute-vector-int32
=item permute-vector-uint32

…and so on.

=head3 permute-vector-inv(Math::Libgsl::Vector $v)

This method applies the inverse permutation to a Vector object and returns the Vector object itself.
As in the case of the Vector object, this method is available for all the supported data type, so we have

=item permute-vector-inv-num32
=item permute-vector-inv-int32
=item permute-vector-inv-uint32

…and so on.

=head3 permute-matrix(Math::Libgsl::Matrix $m)
This method applies the permutation to a Matrix object and returns the Matrix object itself.
As in the case of the Matrix object, this method is available for all the supported data type, so we have

=item permute-matrix-num32
=item permute-matrix-int32
=item permute-matrix-uint32

…and so on.

=head3 write(Str $filename! --> Int)

This method writes the permutation data to a file.

=head3 read(Str $filename! --> Int)

This method reads the permutation data from a file.
The permutation must be of the same size of the one to be read.

=head3 fprintf(Str $filename!, Str $format! --> Int)

This method writes the permutation data to a file, using the format specifier.

=head3 fscanf(Str $filename!)

This method reads the permutation data from a file.
The permutation must be of the same size of the one to be read.

=head3 multiply($dst! where * ~~ Math::Libgsl::Permutation, $p2! where * ~~ Math::Libgsl::Permutation)

This method combines the current permutation with the permutation B<$p2>, stores the result into B<$dst> and returns B<self>.

=head3 to-canonical($dst! where * ~~ Math::Libgsl::Permutation)

This method computes the canonical form of the current permutation, stores the result into B<$dst> and returns B<self>.

=head3 to-linear($dst! where * ~~ Math::Libgsl::Permutation)

This method computes the linear form of the current permutation, stores the result into B<$dst> and returns B<self>.

=head3 inversions(--> Int)

This method counts the number of inversions in the current permutation.

=head3 linear-cycles(--> Int)

This method counts the number of cycles in the current permutation given in linear form.

=head3 canonical-cycles(--> Int)

This method counts the number of cycles in the current permutation given in canonical form.

=head1 C Library Documentation

For more details on libgsl see L<https://www.gnu.org/software/gsl/>.
The excellent C Library manual is available here L<https://www.gnu.org/software/gsl/doc/html/index.html>, or here L<https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf> in PDF format.

=head1 Prerequisites

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

=head2 Debian Linux and Ubuntu 20.04

=begin code
sudo apt install libgsl23 libgsl-dev libgslcblas0
=end code

That command will install libgslcblas0 as well, since it's used by the GSL.

=head2 Ubuntu 18.04

libgsl23 and libgslcblas0 have a missing symbol on Ubuntu 18.04.
I solved the issue installing the Debian Buster version of those three libraries:

=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb>
=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb>
=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb>

=head1 Installation

To install it using zef (a module management tool):

=begin code
$ zef install Math::Libgsl::Permutation
=end code

=head1 AUTHOR

Fernando Santagata <nando.santagata@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2020 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
