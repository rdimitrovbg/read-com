# Serial Port Reader Script
Overview

This PowerShell script, read-com.ps1, is designed to interactively configure and read data from a serial port. It provides a user-friendly interface for selecting various parameters such as the serial port, baud rate, parity bits, data bits, stop bits, and output format (ASCII or HEX). Once configured, the script continuously reads data from the selected serial port and displays it in the chosen output format.

## Features

### Interactive Configuration:
Users can select the serial port from a list of available ports and customize various settings such as baud rate, parity bits, data bits, stop bits, and output format. 
Flexible Output Format: Supports both ASCII and HEX output formats for displaying the received data.
Exception Handling: Incorporates error handling mechanisms to address common issues such as unauthorized access to the serial port.
Clean User Interface: The script offers a clear and visually appealing command-line interface, making it easy for users to navigate and configure the serial port settings.

## Usage

### Running the Script:
Execute the read-com.ps1 script in a PowerShell environment.
Selecting Serial Port: Choose the desired serial port from the list of available ports.
Configuring Parameters: Follow the prompts to select the baud rate, parity bits, data bits, stop bits, and output format.
Reading Data: Once configured, the script continuously reads data from the selected serial port and displays it on the console.

## Requirements

+ PowerShell environment
+ Windows operating system (for accessing serial ports)
+ Serial device connected to the computer

## Compatibility

  Compatible with Windows operating systems.
  Requires PowerShell version 3.0 or higher.

## Additional Notes

  Ensure that the script is executed with appropriate permissions to access serial ports. Users may need to run PowerShell with elevated privileges or adjust security settings to avoid permission issues.
  For optimal performance, it is recommended to close other applications accessing the serial port to prevent conflicts.
  This script serves as a versatile tool for monitoring and debugging serial communication, suitable for various applications such as embedded systems development, IoT projects, and hardware testing.
