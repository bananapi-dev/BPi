DIA     :=/usr/bin/dia
DOT     :=/usr/bin/dot
INKSCAPE:=/usr/bin/inkscape
EPSTOPDF:=`which epstopdf`
MPOST   :=/usr/bin/mpost
CONVERT :=/usr/bin/convert  

#image-sources := \
#ClusterWAN.dia \
#EnterprizeHobbit.dia \
#ExistingOneNodeLooselyCpupledClusterWAN.dia \
#HALAN.dia \
#HobbitDataPatching.dia \
#HobbitDataZFSFailover.dia \
#hobbit-ha-wan-SEAMLESS_Proposal.dia \
#network-2-computers.dia \
#OneNodeClusterPairWAN.dia \
#OneNodeClusterWAN.dia \
#OneNodeLooselyCpupledClusterWAN.dia \
#testcase1.dia \
#TwoNodeLooselyCpupledClusterWAN.dia \
#TwoNodeLooselyCpupledClusterWAN-NAS.dia \
#TwoNodeLooselyCpupledClusterWAN-RRDpatching.dia \
#TwoNodesClusterLAN.dia \
#TwoNodesClusterPairWAN.dia \
#TwoNodesClusterWAN.dia \
#TwoNodesTightlyCpupledClusterLAN.dia \
#VictorStinnerAutotools.dia \
#WAN-failover.dia \
#WAN-failover-doublecheck.dia \
#WAN-failover-master-standby.dia \
#WAN-failover-master-standby-general.dia \
#xymonasset.dia \
#xymon-client.dia \
#XymonClient.dia \
#xymon-daemons-clustering.dia \
#xymon-daemons.dia \
#Xymon-Server.dia \
#xymon-daemons.dia \
#unix.dot  \
#pms.dot
#
#             (filter, matched pattern,filenames)
#image-dot   := $(filter %.dot,$(image-sources))
#image-dia   := $(filter %.dia,$(image-sources))

# Rules

%.eps: %.dia
	$(DIA) -t eps $< 
%.pdf: %.eps
	$(EPSTOPDF)  $<
# dot converting to svg format
%.svg: %.dot
	$(DOT) -Tsvg -o $@ $<
# svg then converted to png format using inkscape.
# Produce 90dpi PNGs for the web.
%.png: %.svg
	$(INKSCAPE) -D -e $@ $<
#    $(patsubst pattern,replacement,text)
#For example, you might have a list of object files:
#          objects = foo.o bar.o baz.o
#To get the list of corresponding source files, you could simply write:
#          $(objects:.o=.c)
#instead of using the general form:
#          $(patsubst %.o,%.c,$(objects))
#
pdfs := $(patsubst %.dia,%.pdf,$(wildcard *.dia))
pngs := $(patsubst %.dot,%.png,$(wildcard *.dot))


all:${pdfs}  ${pngs} 

clean:  
	rm -f *.pdf *~
