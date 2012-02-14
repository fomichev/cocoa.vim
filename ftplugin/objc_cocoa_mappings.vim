" File: objc_cocoa_mappings.vim
" Author: Michael Sanders (msanders42 [at] gmail [dot] com)
" Description: Sets up mappings for cocoa.vim.
" Last Updated: December 26, 2009

" use custom man
nn <buffer> <silent> K :<c-u>call objc#man#ShowDoc()<cr>

" use xcodebuild as make program
setlocal makeprg=xcodebuild\ -sdk\ iphonesimulator5.0

" Xcode bindings
let b:cocoa_proj = fnameescape(globpath(expand('<afile>:p:h'), '*.xcodeproj'))
" Search a few levels up to see if we can find the project file
if empty(b:cocoa_proj)
	let b:cocoa_proj  = fnameescape(globpath(expand('<afile>:p:h:h'), '*.xcodeproj'))

	if empty(b:cocoa_proj)
		let b:cocoa_proj = fnameescape(globpath(expand('<afile>:p:h:h:h'), '*.xcodeproj'))
		if empty(b:cocoa_proj)
			let b:cocoa_proj = fnameescape(globpath(expand('<afile>:p:h:h:h:h'), '*.xcodeproj'))
		endif
	endif
endif

function s:ExecInXcode(command)
	" Build   Cmd-B
	" Run     Cmd-R
	" Test    Cmd-U
	" Profile Cmd-I
	" Analyze Cmd-shift-B
	" Clean   Cmd-shift-K

	let cmd = a:command

	let command_map = { 'Build': 11, 'Run': 15, 'Test': 32, 'Profile': 34 }
	let command_shift_map = { 'Analyze': 11, 'Clean': 40 }

	if(get(command_map, cmd, "") != "")
		let code = command_map[cmd]. " using {command down}"
	elseif(get(command_shift_map, cmd, "") != "")
		let code = command_shift_map[cmd]. " using {command down, shift down}"
	end

	call system("open -a Xcode.app " . b:cocoa_proj . " && osascript -e '"
				\ ."tell application \"Xcode\" to activate \r"
				\ ."tell application \"System Events\" \r"
				\ ."     tell process \"Xcode\" \r"
				\ ."          key code " . code . " \r"
				\ ."    end tell \r"
				\ ."end tell'")
endfunction

nn <buffer> <d-r> :w<bar>call <SID>ExecInXcode('Run')<cr>
nn <buffer> <d-b> :w<bar>call <SID>ExecInXcode('Build')<cr>
nn <buffer> <d-u> :w<bar>call <SID>ExecInXcode('Test')<cr>
nn <buffer> <d-i> :w<bar>call <SID>ExecInXcode('Profile')<cr>
nn <buffer> <d-B> :w<bar>call <SID>ExecInXcode('Analyze')<cr>
nn <buffer> <d-K> :w<bar>call <SID>ExecInXcode('Clean')<cr>
