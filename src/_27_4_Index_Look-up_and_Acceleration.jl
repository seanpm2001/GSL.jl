#!/usr/bin/env julia
#GSL Julia wrapper
#(c) 2013 Jiahao Chen <jiahao@mit.edu>
#######################################
# 27.4 Index Look-up and Acceleration #
#######################################
export gsl_interp_bsearch, gsl_interp_accel_alloc, gsl_interp_accel_find,
       gsl_interp_accel_reset, gsl_interp_accel_free


# This function returns the index i of the array x_array such that x_array[i]
# <= x < x_array[i+1].  The index is searched for in the range
# [index_lo,index_hi].  An inline version of this function is used when
# HAVE_INLINE is defined.
# 
#   Returns: Csize_t
function gsl_interp_bsearch(x_array::Cdouble)
    ccall( (:gsl_interp_bsearch, :libgsl), Csize_t, (Cdouble, ), x_array )
end


# This function returns a pointer to an accelerator object, which is a kind of
# iterator for interpolation lookups.  It tracks the state of lookups, thus
# allowing for application of various acceleration strategies.
# 
#   Returns: Ptr{Void}
#XXX Unknown output type Ptr{gsl_interp_accel}
#XXX Coerced type for output Ptr{Void}
function gsl_interp_accel_alloc()
    ccall( (:gsl_interp_accel_alloc, :libgsl), Ptr{Void}, () )
end


# This function performs a lookup action on the data array x_array of size
# size, using the given accelerator a.  This is how lookups are performed
# during evaluation of an interpolation.  The function returns an index i such
# that x_array[i] <= x < x_array[i+1].  An inline version of this function is
# used when HAVE_INLINE is defined.
# 
#   Returns: Csize_t
#XXX Unknown input type a::Ptr{gsl_interp_accel}
#XXX Coerced type for a::Ptr{Void}
function gsl_interp_accel_find(a::Ptr{Void}, x_array::Cdouble)
    ccall( (:gsl_interp_accel_find, :libgsl), Csize_t, (Ptr{Void},
        Cdouble), a, x_array )
end


# This function reinitializes the accelerator object acc.  It should be used
# when the cached information is no longer applicable—for example, when
# switching to a new dataset.
# 
#   Returns: Cint
#XXX Unknown input type acc::Ptr{gsl_interp_accel}
#XXX Coerced type for acc::Ptr{Void}
function gsl_interp_accel_reset(acc::Ptr{Void})
    gsl_errno = ccall( (:gsl_interp_accel_reset, :libgsl), Cint,
        (Ptr{Void}, ), acc )
    if gsl_errno!= 0 throw(GSL_ERROR(gsl_errno)) end
end


# This function frees the accelerator object acc.
# 
#   Returns: Void
#XXX Unknown input type acc::Ptr{gsl_interp_accel}
#XXX Coerced type for acc::Ptr{Void}
function gsl_interp_accel_free(acc::Ptr{Void})
    ccall( (:gsl_interp_accel_free, :libgsl), Void, (Ptr{Void}, ), acc )
end