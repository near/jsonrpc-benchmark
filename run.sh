#!/bin/bash
drill --benchmark view_call.yml --quiet --stats
drill --benchmark view_access_key_list.yml --quiet --stats
drill --benchmark view_account.yml --quiet --stats
drill --benchmark view_state.yml --quiet --stats
