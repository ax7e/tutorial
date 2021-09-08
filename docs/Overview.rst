===========
Overview
===========

.. figure:: images/system.png
    :align: center
    :figwidth: 1000px

As Moore’s law is approaching to the end, designing specialized hardware along with the software that map the applications onto the specialized hardware is a promising solution. The hardware design determines the peak performance, while the software is also important as it determines the actual performance. Hardware/software (HW/SW) co-design can optimize the hardware acceleration and software mapping in concert and improve overall performance. However, the current flow designs hardware and software in isolation. More importantly, both hardware and software are difficult to design and optimize due to the low level programming and huge design space.

In this tutorial, we present AHS, an Agile framework for Hardware specialization and Software mapping for tensor applications. Given a tensor application described using high level language, AHS can automatically define the interfaces between the hardware and software, navigate the huge design space synergistically, and automatically generate the hardware implementation and software mapping. AHS consists of several components and each component comes with an open source tool. First, we introduce HASCO [ISCA’21], a tool for hardware and software co-design. HASCO uses a matching approach based on a loop-based IR to explore different HW/SW partitioning methods. HASCO employs different DSE algorithms for hardware and software due to different design goals and evaluation costs. Second, we introduce TENET [ISCA’21], a tool for hardware dataflow notation and performance model. TENET can cover the design space of hardware dataflows completely using relation-centric notation. Third, we introduce TensorLib [DAC’21], the synthesis backend for TENET. TensorLib can automatically generate the hardware dataflow implementation written in Chisel. Finally, we introduce Flextensor [ASPLOS’20], a tool for automatic software mapping and optimization. Flextensor can automatically generate optimized software implementation for various hardware platforms including CPUs, GPUs, FPGAs, and ASICs. 

======================
Schedule
======================

The tutorial starts with an overview of the AHS Project followed by a series of technical presentation and open source tools demo. The tutorial covers all the components of AHS including hardware and software co-design, hardware specialization, and software mapping. 

.. list-table:: Schedule
   :widths: 25 25 50
   :header-rows: 1

   * - Time
     - Agenda
     - Presenter
   * - 10mins
     - Overview
     - Yun Eric Liang
   * - 40mins
     - HASCO: co-design framework
     - Zizhang Luo
   * - 40mins
     - TENET: hardware dataflow modeling
     - Liqiang Lu
   * - 10mins
     - Break
     - \
   * - 40mins
     - Tensorlib: automatic hardware synthesis
     - Liangcheng Jia
   * - 40mins
     - FlexTensor: automatic software mapping
     - Size Zheng


==========
Organizers
==========

-  Yun (Eric) Liang is currently an associate professor at School of EECS, Peking University. His research interests include computer architecture, electronic design automation, and compiler. He has authored over 100 scientific publications in ISCA, MICRO, DAC, FPGA, etc. His research has been recognized by two best paper awards and six best paper nominations. He serves as technical program committees for MICRO, ISCA, ASPLOS, HPCA, DAC, FPGA, FCCM, etc. and associate editors for ACM TECS and TRETS.
-  Zizhang Luo is currently a final year under-graduate student at Peking University. He is interested in architecture and software co-design for domain specific chips. 
-  Liqiang Lu is a 5th year PhD student at Peking University. He obtained his B.S. degree from the same university in 2017. He is interested in spatial architecture and reconfigurable computing. 
- Liancheng Jia is a 4rd year PhD student at Peking University. He obtained his B.S degree from the same university in 2018. He is interested in high level synthesis and agile hardware design.
-  Size Zheng is a 3rd year PhD student at Peking University. He obtained his B.S degree from the same university in 2019. He is interested in compiler design and optimization for domain specific accelerators. 

=====================
Related papers
=====================

-  Size Zheng, et al. “FlexTensor: An Automatic Schedule Exploration and Optimization Framework for Tensor Computation on Heterogeneous System,” ASPLOS, 2020.
-  Qingcheng Xiao, et al. “HASCO: Towards Agile Hardware and Software Co-design for Tensor Computation,” ISCA, 2021.
-  Liqiang Lu, et al. “TENET: A Framework for Modeling Tensor Dataflow based on Relation-centric Notation,” ISCA, 2021.
-  Liancheng Jia, et al. “TensorLib: A Spatial Accelerator Generation Framework for Tensor Algebra,” DAC, 2021.
