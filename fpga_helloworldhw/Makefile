SHELL=/bin/bash
CONDATOOL=/opt/symbiflow/eos-s3/conda
TOP := helloworldfpga
VERILOG := helloworldfpga.v  
PARTNAME := PU64
DEVICE  := ql-eos-s3_wlcsp
PCF := quickfeather.pcf
SDC := helloworldfpga_dummy.sdc
BUILDDIR := build

 
.PHONY: all
all: ${BUILDDIR}/${TOP}.bit 
#all: ${BUILDDIR}/${TOP}_bit.h ${BUILDDIR}/${TOP}_jlink.h ${BUILDDIR}/${TOP}.post_v

${BUILDDIR}:
	mkdir ${BUILDDIR}

${BUILDDIR}/${TOP}.eblif: ${VERILOG} ${BUILDDIR}
	cd ${BUILDDIR} && symbiflow_synth -t ${TOP} -v ../${VERILOG} -d ${DEVICE} -p ../${PCF} -P ${PART} 2>&1 > ${TOP}.log

${BUILDDIR}/${TOP}.net: ${BUILDDIR}/${TOP}.eblif
	cd ${BUILDDIR} && symbiflow_pack -e ${TOP}.eblif -d ${DEVICE} -s ${SDC} 2>&1 >> ${TOP}.log

${BUILDDIR}/${TOP}.place: ${BUILDDIR}/${TOP}.net
	cd ${BUILDDIR} && symbiflow_place -e ${TOP}.eblif -d ${DEVICE} -p ../${PCF} -n ${TOP}.net -P ${PARTNAME} -s ${SDC} 2>&1 >> ${TOP}.log

${BUILDDIR}/${TOP}.route: ${BUILDDIR}/${TOP}.place
	cd ${BUILDDIR} && symbiflow_route -e ${TOP}.eblif -d ${DEVICE} -s ${SDC} 2>&1 >> ${TOP}.log

${BUILDDIR}/${TOP}.fasm: ${BUILDDIR}/${TOP}.route
	cd ${BUILDDIR} && symbiflow_write_fasm -e ${TOP}.eblif -d ${DEVICE} 2>&1 >> ${TOP}.log

${BUILDDIR}/${TOP}.bit: ${BUILDDIR}/${TOP}.fasm
	cd ${BUILDDIR} && symbiflow_write_bitstream -d ${DEVICE} -f ${TOP}.fasm -P ${PARTNAME} -b ${TOP}.bit 2>&1 >> ${TOP}.log

${BUILDDIR}/${TOP}_bit.h: ${BUILDDIR}/${TOP}.bit
	cd ${BUILDDIR} && symbiflow_write_bitheader -b ${TOP}.bit 2>&1 >> ${TOP}.log

${BUILDDIR}/${TOP}.jlink: ${BUILDDIR}/${TOP}.bit
	cd ${BUILDDIR} && symbiflow_write_jlink -f ${TOP}.fasm -P ${PACKAGENAME} -b ${TOP}.bit 2>&1 >> ${TOP}.log

${BUILDDIR}/${TOP}_jlink.h: ${BUILDDIR}/${TOP}.jlink
	cd ${BUILDDIR} && symbiflow_write_jlinkheader 2>&1 >> ${TOP}.log

${BUILDDIR}/${TOP}.post_v: ${BUILDDIR}/${TOP}.bit
	cd ${BUILDDIR} && symbiflow_write_fasm2bels -e ${TOP}.eblif -d ${DEVICE} -p ../${PCF} -n ${TOP}.net -P ${PARTNAME} 2>&1 >> ${TOP}.log
	cd ${BUILDDIR} && symbiflow_analysis -e ${TOP}.eblif -d ${DEVICE} -s ${SDC} 2>&1 >> ${TOP}.log

.PHONY: clean
clean:
	rm -rf ${BUILDDIR}





