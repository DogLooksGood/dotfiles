#!/usr/bin/env python

'''
This script takes a workspace and moves it to another screen irrespective of geometry. It is in particular
useful for those with 'exotic' screen configurations where "move right" won't necessarily cycle through all of the
screens.
It will not break by changing active outputs (such as connecting screens to a tablet PC)
By default this script will cycle in order of the RandR list of displays.
Custom display order can be specified using the custom_order variable below
'''

import i3

# The following line to set order manually. Should still work if the entries aren't active. Comment if not needed.
#custom_order = ('DP2-1','DP2-2','eDP1')

def main():
    outputs = i3.get_outputs()          # get all outputs (used to locate the active outputs available to i3)
    workspaces = i3.get_workspaces()    # get all workspaces (used to locate the output that currently has focus so it can be moved)

    active_outputs = [o['name'] for o in outputs if o['active'] is True]        # get a list of all active outputs
    current_output = [o['output'] for o in workspaces if o['focused'] is True]  # get a list of the current output
    current_output = current_output[0]                                          # take it out of list and make it a string

    if 'custom_order' in globals():
        active_outputs.sort(key=lambda x: custom_order.index(x))

    for i in range(len(active_outputs)):            # Let's look at all the current outputs
        if current_output == active_outputs[i]:     # and find the current output
            if i == len(active_outputs)-1:          # If the current output is at the end of the list
                i3.command('move', 'workspace to output %s'%active_outputs[0])      # send the workspace back to the first output
            else:
                i3.command('move', 'workspace to output %s'%active_outputs[i+1])    # otherwise send it to the next one

if __name__ == '__main__':
    main()
