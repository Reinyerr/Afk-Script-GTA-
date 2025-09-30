#Requires AutoHotkey v2.0
MsgBox "Script Running. Press F1 to start the script. Press F2 to stop the script. Press F3 to exit the script while it is running. Press F4 terminate the GTA V process."

gtaTarget := "Grand Theft Auto V"  ; <- use this if you prefer matching by window title

F1:: {
    global stopflag
    stopflag := false
    MsgBox "Starting script. Press F2 to stop."

    Loop {
        if stopflag {
            MsgBox "Script stopped."
            return
        }

        prev := WinGetID("A")  ; remember current window
        WinActivate(gtaTarget) ; Activate GTA window
        WinWaitActive(gtaTarget) ; Wait until the window is active

        Sleep 400 ; Small delay so the new window is active

        ; Random 1–10 clicks
        clickCount := Random(0, 1)
        Loop clickCount {
            if stopflag
                return
            Click
            Sleep 100
        }

        ; Random 1–5 movement keys with random hold times
        movement := Random(1, 8)
        keys := ["W", "A", "S", "D", "Space"]
        Loop movement {
            if stopflag
                return
            randKey := keys[Random(1, keys.Length)]
            Send "{" randKey " down}"
            Sleep Random(50, 300) ; Hold key down for 50–300 ms
            Send "{" randKey " up}"
            Sleep Random(100, 400) ; Delay before next movement
        }

        if prev
            WinActivate(prev)

        ; Wait 14 min in 1-sec chunks so F2 can stop anytime
        totalWait := 840000
        while (totalWait > 0 && !stopflag) {
            Sleep 1000
            totalWait -= 1000
        }
    }
}

F2::{
    MsgBox "Stopping Script"
    global stopflag := !stopflag ; Toggle the stop flag

} 

F3::{
    MsgBox "Exiting script."
    ExitApp
} ;Exit app when F2 is pressed


; Press F4 to Alt+F4 GTA and spam Enter until it closes
F4:: {
    ; Send Alt+F4 to request close
    Send "!{F4}"
    Sleep 200

    ; Spam Enter for up to 5 seconds or until GTA closes
    startTime := A_TickCount
    while (WinExist("Grand Theft Auto V") && (A_TickCount - startTime < 5000)) {
        Send "{Enter}"
        Sleep 100
    }
}





    

