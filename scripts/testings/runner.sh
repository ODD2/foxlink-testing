. scripts/testings/envs.sh

if [[ $1 == "local" ]];
then

    # reset foxlink database
    bash scripts/systems/clean_server.sh db
    bash scripts/systems/start_server.sh db $SCENARIO_DB_TAG

    # reset mqtt server
    bash scripts/systems/clean_server.sh emqx
    bash scripts/systems/start_server.sh emqx

elif [[ $1 == "remote" ]];
then

    # reset foxlink database
    bash scripts/systems/clean_server.sh db
    bash scripts/systems/start_server.sh db $SCENARIO_DB_TAG

    # reset all remote servers (emqx, backend,api-db)
    bash scripts/testings/restart_servers.sh

else
    echo "please specify the valid condition..."
    exit 0
fi

sleep 5
TIME_FULL="$(date --date='5 minute' +'%Y-%m-%d %H:%M:%S')"
# create time
python -m app.utils.create_time -f $SCENARIO -s "$TIME_FULL" 
# # run foxlinkevents
# python -m app.foxlinkevent $SCENARIO &
# # run test case
# python -m app.worker $SCENARIO
python -m app.execute $SCENARIO