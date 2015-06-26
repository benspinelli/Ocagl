/* This file is magic. Normalizing arrays of vectors is a time consuming but
 * common task in computer graphics. In this file, we temporarily break away
 * from Ocaml to indulge in hacky, bit-level black magic. In doing so, we
 * are able to outperform C++ compiled with -O2 by 15-20% -- all while still
 * accessing this function from a garbage collected, high-level language!!
 */

#define CAML_NAME_SPACE

#include <caml/mlvalues.h>

/* This is a fast inverse square root approximation algorithm, for optimizing
 * normalization of vectors. The algorithm is based on a similar version for
 * single precision floats by John Carmack and an extension to arbitary
 * precision formats by Chris Lomont (lomont.org/Math/Papers/2003/InvSqrt.pdf)
 */
inline double fastInvSqrt(double x) {
    double xhalf = 0.5 * x;
    long i = *(long *) &x;
    i = 0x5fe6ec85e7de30da - (i>>1);    // "magic" approximation
    x = *(double *) &i;
    x = x * (1.5 - xhalf*x*x);          // one step of newton's method
    return x;
}

/* Wrap with appropriate type conversion between C and ML bit representations */
value fastInvSqrtArr(value arr) {
    int len = (int) caml_array_length(arr);
    int i = 0;

    for (i = 0; i < len; i += 3) {
        double x = Double_field(arr, i);
        double y = Double_field(arr, i + 1);
        double z = Double_field(arr, i + 2);

        double ilen = fastInvSqrt(x*x + y*y + z*z);

        Store_double_field(arr, i, x * ilen);
        Store_double_field(arr, i + 1, y * ilen);
        Store_double_field(arr, i + 2, z * ilen);
    }

    return (Val_unit);
}
