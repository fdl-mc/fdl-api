const express = require('express');
const firebase = require('firebase-admin');
const serviceAccount = require('только вот я вам не дам, все таки база данных закрытая =) кароч тут нужен жсон файл для админки бд');
require('firebase/auth');
require('firebase/database');
require('firebase/firestore');

let app = express();
firebase.initializeApp({
    credential: firebase.credential.cert(serviceAccount),
});
let db = firebase.firestore();

app.get('/pay', (req, res) => {
    const payer = req.query.payer;
    const payee = req.query.payee;
    const amount = req.query.amount;

    let payerObj;
    let payeeObj;

    // CALBACK HEEEEEEEELLLLL
    // LESS GOOOOOOOOOOOOOOOO
    db.collection('users')
        .doc(payer)
        .get()
        .then((query) => {
            payerObj = query.docs[0];
            db.collection('users')
                .where('name', '==', payee)
                .get()
                .then((queryy) => {
                    payeeObj = queryy.docs[0];
                    if (payeeObj == null || payeeObj == undefined) {
                        res.send('user-not-found');
                    } else {
                        payerObj.ref
                            .update({
                                balance: parseInt(
                                    parseInt(payerObj.data().balance) - amount
                                ),
                            })
                            .then(() => {
                                payeeObj.ref
                                    .update({
                                        // fuck you string casting
                                        balance:
                                            payeeObj.data().balance - -amount,
                                    })
                                    .then(() => {
                                        res.send('ok');
                                    })
                                    .catch((e) => console.log(e));
                            })
                            .catch((e) => console.log(e));
                    }
                })
                .catch((e) => console.log(e));
        });
});

app.listen(3000, () => {
    console.log('ok i started');
});
