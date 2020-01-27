FROM rthosfeltcmu/cmu_xview2_baseline:verbose

ADD test_pre_00422.png /
ADD test_post_00422.png /

# Replace the cloned run.sh with the one from this local debug dir
ADD run.sh /home/appuser/code/xview-2/submission/run.sh
#RUN chmod a+x /home/appuser/code/xview-2/submission/run.sh

# Switch to root user to modify fs permissions
USER root

# Find dirs, and give them read/write permissions
#RUN find / -type d -exec chmod 777 {} \;
RUN chmod a+r /
RUN ls -l /*.png
RUN chmod a+rw /test_post_00422.png
RUN chmod a+rw /test_post_00422.png
RUN ls -l /*.png

RUN  chmod a+r /home
RUN find /home/ -type d -exec chmod a+r {} \;
RUN chmod a+rw /tmp
RUN find /tmp/ -type d -exec chmod a+rw {} \;

# Switch back to CMU app user
#USER appuser
#WORKDIR /home/appuser