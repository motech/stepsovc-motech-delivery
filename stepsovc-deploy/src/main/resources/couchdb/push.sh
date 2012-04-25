for app_file in *.json; do
	echo $app_file
done
#reply=$(curl -i  -X POST  "http://localhost:5984/test" -H "Content-Type:application/json"  -d @steps_ovc_admin.json | grep {)
#echo $reply
#id=$(echo $reply | jsawk 'return this.id')
#rev=$(echo $reply | jsawk 'return this.rev')
#echo 'id='$id
#echo 'rev='$rev
