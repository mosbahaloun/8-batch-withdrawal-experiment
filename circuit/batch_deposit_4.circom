pragma circom 2.0.0;
include "./commitment_hasher.circom";

template BatchDeposit4() {
    signal input secret[4][256];
    signal input nullifier[4][256];
    signal output commitment[4];
    signal output nullifierHash[4];
    
    component cHasher[4];
    
    for (var t = 0; t < 4; t++) {
        cHasher[t] = CommitmentHasher();
        
        for (var i = 0; i < 256; i++) {
            cHasher[t].secret[i] <== secret[t][i];
            cHasher[t].nullifier[i] <== nullifier[t][i];
        }
        
        commitment[t] <== cHasher[t].commitment;
        nullifierHash[t] <== cHasher[t].nullifierHash;
    }
}

component main = BatchDeposit4();