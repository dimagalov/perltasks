use strict;
use warnings;

use Test::More tests => 2;

use Local::PerlCourse::JSONP qw(custom_decode_json);


is_deeply(
    custom_decode_json(
        qq<{"a":[1,2,3]}>
    ),
    {a => [1, 2, 3]},
    'decode JSON -- small'
);

is_deeply(
    custom_decode_json(
        qq<{"key1": "string value",
        "key2": -3.1415,
        "key3": ["nested array"],
        "key4": { "nested": "object" }
        }>
    ),
    {
        key1 => "string value",
        key2 => -3.1415,
        key3 => [
            "nested array"
        ],
        key4 => {
            nested => "object"
        }
    },
    'decode JSON -- big'
);
