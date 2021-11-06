# ===============================================================================
# OS and compiler dependent settings.
# ===============================================================================
if (UNIX)
	# -------------------------------------------------------------------------------
	# On Unix
	# -------------------------------------------------------------------------------
	set(OS_SCRIPT_FILE_ENDING .sh)
	set(OS_EXECUTE_POSTFIX ./ )
    set(CMAKE_CURRENT_USERNAME $ENV{USER})
else()
	# -------------------------------------------------------------------------------
	# On Windows
	# -------------------------------------------------------------------------------
	set(OS_SCRIPT_FILE_ENDING .bat)
	set(OS_EXECUTE_POSTFIX )
    set(CMAKE_CURRENT_USERNAME $ENV{USERNAME})
endif()
