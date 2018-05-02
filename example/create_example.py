#!/usr/bin/python

"""
This module can create the TUNE example application using either the latest 
TUNE SDK, or build it from local TUNE SDK sources.

Example: Create the project and add the latest version of TUNE
    $ python create_example.py -c

Example: Create the project, build, deploy, and run
    $ python create_example.py -c -b -r

Example: Create the project using a different output path (./testing)
    $ python create_example.py -c -p testing

Example: Create the project using a local SDK path
    $ python create_example.py -c --sdk ~/tune/sdk-phonegap

"""
import os
import sys
import argparse

title = 'Tune Cordova Example'
default_path = './example'
default_sdk = 'cordova-plugin-tune'

# Create an Argument Parser
parser = argparse.ArgumentParser(description=title)
parser.add_argument('-c', '--create', help='Create the ' + title, action='store_true', dest='_create')
parser.add_argument('-b', '--build', help='Build the ' + title, action='store_true', dest='_build')
parser.add_argument('-r', '--run', help='Run the ' + title, action='store_true', dest='_run')
parser.add_argument('-p', '--path', help='Destination path.  Default is ' + default_path, type=str, dest='path', default=default_path)
parser.add_argument('--sdk', help='SDK path', type=str, dest='sdkpath', default='cordova-plugin-tune')
args = parser.parse_args()

if len(sys.argv) == 1:
	parser.print_help()
	print(__doc__)
	quit()

# Pre-Check to see if the destination exists
exists=os.path.exists(args.path)

# Create the Tune PhoneGap Example
if args._create:
	if exists:
		print args.path + " already exists"
		quit()

	cmd="cordova create " + args.path + " com.hasoffers.phonegaptestapp Example"
	os.system(cmd)

# Post-Check to see if the desination exists
exists=os.path.exists(args.path)

if not exists:
	print args.path + " doesn't exist.  Create the project first!"
	quit()

# Change directory into the project folder
os.chdir(args.path)

# Add Android support
if args._create:
	os.system("cordova platform add android")

# Add the SDK
if len(args.sdkpath) > 0:
	os.system("cordova plugin add " + args.sdkpath)

	# Copy the Tune plugin example
	exists=os.path.exists('plugins/cordova-plugin-tune/example/index.html')
	if exists:
		os.system("cp plugins/cordova-plugin-tune/example/index.html ./www")

# Build
if args._build or args._run:
	os.system("cordova build")

# Run
if args._run:
	os.system("cordova run")

