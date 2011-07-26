Bucketer
========

Task description - see below


Installation
------------

```
git clone git://github.com/tepoga/bucketer.git
cd bucketer
bundle install
```

To run it from command line:

```
ruby bucketer.rb input.txt 3
```

Parameters:

* input.txt - file with input data in json format. E.g [1,2,3,4,5]
* 3 - average number of items per bucket


Algorithm description:
----------------------

First we need to define average bucket length:
avg_length = time_interval / avg_items_per_bucket
where time_interval = input.last - input.first

Then we split the whole time interval into random intervals with mean
value of avg_length. That is all.

Note that it's only possible to get the required number of items per
bucket if you allow empty buckets in the result (ALLOW_EMPTY_BUCKETS
constant). This is actually quite logical - a bucket with no elements
have a right to exist. If empty buckets are disabled, the resulting
average number of items will be a larger by some amount (depending on
the input data).

No error handling provided: it's up to the user to ensure that input
file exists and contains valid json and he's not recommended to enter
0 as average number of items value.


Real life example
-----------------

John booted his laptop to add some photos at 9:00. At 9:10 he was
finished with it, having added 5 photos. Then he added 5 more photos
at 11:00 and one more at 15:00. We may end up with such input data:

[1, 60, 120, 500, 600, 7200, 7210, 7300, 7400, 7410, 21600]

If we run bucketer 10 times with this data, we'll get this:

    > time ruby bucketer.rb input3.txt 2
    [[1, 60, 120, 500, 600], [7200, 7210, 7300, 7400, 7410], [21600]]
    [[1, 60, 120, 500, 600], [7200, 7210, 7300, 7400, 7410, 21600]]
    [[1, 60, 120, 500, 600], [7200, 7210, 7300, 7400, 7410], [21600]]
    [[1, 60, 120, 500, 600], [7200, 7210, 7300, 7400, 7410], [21600]]
    [[1, 60, 120, 500, 600], [7200, 7210, 7300, 7400, 7410], [21600]]
    [[1, 60, 120, 500], [600], [7200, 7210, 7300, 7400, 7410], [21600]]
    [[1, 60, 120, 500, 600, 7200, 7210, 7300, 7400, 7410], [21600]]
    [[1, 60, 120, 500, 600], [7200, 7210, 7300, 7400, 7410], [21600]]
    [[1, 60, 120, 500, 600, 7200, 7210, 7300, 7400, 7410], [21600]]
    [[1, 60, 120, 500, 600], [7200, 7210, 7300, 7400, 7410], [21600]]

Which seems reasonable: photos tend to group as they were added.



Task description
----------------

Suppose you have a set of photos, all of which have a date taken. Your goal is to create an algorithm that will put the photos into meaningful buckets that can then be used to seed pages in an autoflow’ed book.

For example, if I have 5 photos in my set, and the grouping algorithm creates 2 buckets [[1,4], [2,3,5]], then on page 1 of the book will be photos 1 & 4 and on the next page will be photos 2, 3, & 5.

The algorithm should be non-deterministic and the average number of photos in a set should be adjustable. Also, you can assume that photos that are closer to each other in time proximity are more relevant to each other thus more likely to belong together on the same page. The total number of groups that the algorithm outputs is determined by the algorithm you choose and the input set, not vice-versa. In other words, you cannot specify the number of groups that your algorithm creates before it runs. For example, let’s say you had the following synchronous time events:

`[5, 15, 16, 18, 24]`

Chances are, if you are shooting for an average of 2 photos per page, the algorithm might spit out the following results after being run multiple times:

```
[[5], [15, 16, 18], [24]]
[[5], [15, 16], [18, 24]]
[[5], [15, 16, 18], [24]]
[[5], [15, 16, 18], [24]]
[[5], [15, 16], [18], [24]]
[[5], [15, 16, 18], [24]]
[[5], [15, 16], [18], [24]]
[[5], [15, 16, 18], [24]]
```

Notice how certain results appear more often than others. On any given run, the result could be one of many outcomes, but you tend to see certain outcomes with higher probability. That is not to say we couldn’t get an outcome like [[5], [15], [16], [18], [24]], but there might be a very small chance of it occurring.

Also, please walk me through your logic for choosing you’re algorithm and distributions used. Please use the following data to represent a sequence of linear time. Your output should show how this sequence is grouped so one can understand your algorithms behavior. Please write this algorithm in Ruby and make it so that it can be run from the command line with the outputted groups in the console. Here is the data of time information:

```
[392, 396, 400, 406, 422, 436, 446, 448, 450, 454, 462, 470, 478, 488,
490, 508, 512, 518, 526, 528, 532, 538, 548, 562, 570, 580, 592, 594,
596, 598, 600, 604, 608, 614, 620, 626, 632, 640]
```

Feel free to create additional arrays of numbers to test the corner
cases and verify that your function is behaving as you are expecting
and outputting a result set that a user is most likely to like.

