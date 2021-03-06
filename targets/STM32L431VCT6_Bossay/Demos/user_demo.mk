################################################################################
# this is used for compile the user defined oc demo
################################################################################

#if you have defined multiple demos by yourself, modify this file to compile the chosen demo.

#example for lwm2m

ifeq ($(CONFIG_DEMO_TYPE), "none")	
	CONFIG_USER_DEMO := "oc_agriculture_template"

	#example for oc_streetlight_template
	ifeq ($(CONFIG_USER_DEMO), "oc_streetlight_template")	
		user_demo_src  = ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Demos/oc_streetlight_template/*.c}
		user_demo_inc = -I $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Demos/oc_streetlight_template
		user_hardware_src = ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/BH1750.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/LIGHT.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/BEEP.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/DEMOS/BS_SC_DEMO.c}  
		user_hardware_inc = -I ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox}
		user_demo_defs = -D CONFIG_OC_LWM2M_DEMO_ENABLE=1
		
	endif

	#example for oc_agriculture_template
	ifeq ($(CONFIG_USER_DEMO), "oc_agriculture_template")	
		user_demo_src  = ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Demos/oc_agriculture_template/*.c}
		user_demo_inc = -I $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Demos/oc_agriculture_template
		user_hardware_src = ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/BH1750.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/SHT30.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/BEEP.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/LIGHT.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/MOTOR.c\
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/LED.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/DEMOS/BS_IA_DEMO.c} 
		user_hardware_inc = -I ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox}
		user_demo_defs = -D CONFIG_OC_LWM2M_DEMO_ENABLE=1
		
	endif

	#example for oc_track_template
	ifeq ($(CONFIG_USER_DEMO), "oc_track_template")	
		user_demo_src  = ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Demos/oc_track_template/*.c}
		user_demo_inc = -I $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Demos/oc_track_template
		user_hardware_src = ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/Demos/BS_ST_DEMO.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/BEEP.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/GPS.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/LED.c}
		user_hardware_inc = -I ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox}
		user_demo_defs = -D CONFIG_OC_LWM2M_DEMO_ENABLE=1
		
	endif

	#example for oc_smoke_template
	ifeq ($(CONFIG_USER_DEMO), "oc_smoke_template")	
		user_demo_src  = ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Demos/oc_smoke_template/*.c}
		user_demo_inc = -I $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Demos/oc_smoke_template
		user_hardware_src = ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/Demos/BS_SF_DEMO.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/LED.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/SmokeSensor.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/BEEP.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/LIGHT.c \} 
		user_hardware_inc = -I ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox}
		user_demo_defs = -D CONFIG_OC_LWM2M_DEMO_ENABLE=1
	endif

	#example for hello world	 
	ifeq ($(CONFIG_USER_DEMO), "hello_world_demo")	
		user_demo_src  = ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Demos/hello_world_demo/*.c}
		user_demo_inc = -I $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Demos/hello_world_demo
		user_hardware_src = ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/LED.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/BEEP.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/LIGHT.c \
		$(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/MOTOR.c} 
		user_hardware_inc = -I ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox}
		user_demo_defs = -D CONFIG_HELLO_WORLD_ENABLE=1
	endif

	#example for cloud map 
	ifeq ($(CONFIG_USER_DEMO), "oc_cloud_map_demo")	
		user_demo_src  = ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Demos/oc_cloud_map_demo/*.c}
		user_demo_inc = -I $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Demos/oc_cloud_map_demo
		user_demo_defs = -D CONFIG_OC_LWM2M_CLOUD_MAP_ENABLE=1
	endif

	#example for Test Board
	ifeq ($(CONFIG_USER_DEMO), "Test_board_demo")	
		user_demo_src  = ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Demos/Test_board_demo/*.c}
		user_demo_inc = -I $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Demos/Test_board_demo
		user_hardware_src = ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox/TestBoard.c} 
		user_hardware_inc = -I ${wildcard $(TOP_DIR)/targets/STM32L431VCT6_Bossay/Hardware/IotBox}
		user_demo_defs = -D CONFIG_OC_LWM2M_DEMO_ENABLE=1
		
	endif

	C_SOURCES += $(user_demo_src)
	C_INCLUDES += $(user_demo_inc)
	C_SOURCES += $(user_hardware_src)
	C_INCLUDES += $(user_hardware_inc)
	C_DEFS += $(user_demo_defs)
endif