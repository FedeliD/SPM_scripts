#!/usr/bin/env bash
#FIlename: coord_script.#!/bin/sh


if [[ $@ = "-h" ]]; then
  echo "
  usage: provide a .txt file of comma separated x,y,z MNI coordinates as argument
  standard is Harvard-Oxford Cortical Structural Atlas atlas
  available atlases are:
  AAL
  Cerebellar Atlas in MNI152 space after normalization with FLIRT
  Cerebellar Atlas in MNI152 space after normalization with FNIRT
  Harvard-Oxford Cortical Structural Atlas
  Harvard-Oxford Subcortical Structural Atlas
  Human Sensorimotor Tracts Labels
  JHU ICBM-DTI-81 White-Matter Labels
  JHU White-Matter Tractography Atlas
  Juelich Histological Atlas
  MNI Structural Atlas
  Mars Parietal connectivity-based parcellation
  Mars TPJ connectivity-based parcellation
  Neubert Ventral Frontal connectivity-based parcellation
  Oxford Thalamic Connectivity Probability Atlas
  Oxford-Imanova Striatal Connectivity Atlas 3 sub-regions
  Oxford-Imanova Striatal Connectivity Atlas 7 sub-regions
  Oxford-Imanova Striatal Structural Atlas
  Sallet Dorsal Frontal connectivity-based parcellation
  Subthalamic Nucleus Atlas
  Talairach Daemon Labels"

else
  cat $@ | while read line; do
      echo $line
      #atlasquery -a AAL -c $line
      #atlasquery -a AAL -c $line >> coords_atlasq.txt
      atlasquery -a 'Harvard-Oxford Cortical Structural Atlas' -c $line
      atlasquery -a 'Harvard-Oxford Cortical Structural Atlas' -c $line >> coords_atlasq.txt || echo "NA" >> coords_atlasq.txt

  done
fi



#cat $@ | while read line; do
#    echo $line
#    atlasquery -a AAL -c $line
#    atlasquery -a AAL -c $line >> coords_atlasq.txt
#done
