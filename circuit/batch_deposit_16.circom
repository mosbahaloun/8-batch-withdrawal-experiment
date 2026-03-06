pragma circom 2.0.0;
include "./commitment_hasher.circom";

template BatchDeposit16() {
    signal input secret[16][256];
    signal input nullifier[16][256];
    
    signal output commitment[16];
    signal output nullifierHash[16];
    
    component cHasher[16];
    
    for (var t = 0; t < 16; t++) {
        cHasher[t] = CommitmentHasher();
        
        for (var i = 0; i < 256; i++) {
            cHasher[t].secret[i] <== secret[t][i];
            cHasher[t].nullifier[i] <== nullifier[t][i];
        }
        
        commitment[t] <== cHasher[t].commitment;
        nullifierHash[t] <== cHasher[t].nullifierHash;
    }
}

component main = BatchDeposit16();