get-wmiobject -class win32_logicaldisk | where-object {$_.size -gt 1} | format-table -autosize deviceid, size, freespace, providername
