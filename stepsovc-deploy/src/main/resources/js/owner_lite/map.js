//Lighter weight view doc that strips out actions and xform ids for efficient transfer to caselogic.py
function (doc) {
    if (doc.doc_type === 'CommCareCase') {
        var doc2 = eval(uneval(doc)); //the inbound doc is immutable
        delete doc2.actions;
        delete doc2.xform_ids;
        if (doc.owner_id) {
            var owner_ids = doc.owner_id.toString().split(",");
            for (var i in owner_ids) {
                emit([owner_ids[i], doc.closed], doc2);
            }
        } else {
            emit([doc.user_id, doc.closed], doc2);
        }
    }
}