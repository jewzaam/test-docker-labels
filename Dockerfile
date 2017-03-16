FROM registry.access.redhat.com/rhel7/rhel:7.3-74

LABEL maintainer "Naveen Malik <jewzaam@gmail.com>"

RUN TEST1=1
LABEL test1 $TEST1

ENV TEST2=2
LABEL test2 $TEST2

ARG TEST3=3
LABEL test3 $TEST3

ARG TEST4=4
RUN export TEST4=${TEST4,4.1}
LABEL test4 $TEST4

ARG TEST5=5
ENV TEST5=5.1
LABEL test5 $TEST5

ARG TEST6=6
LABEL test6 $TEST6

RUN echo "I was here" > test.out

CMD /bin/bash
