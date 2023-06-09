pragma solidity >0.7.0 <= 0.9.0;


contract KirimBarang {
    enum Status {DalamPengiriman, Diterima, Gagal}

    struct Paket {
        address pengirim;
        address penerima;
        uint berat;
        string namaBarang;
        Status status;
    }

    Paket[] daftarBarang;

    function PengirimanPaket(address _penerima, uint _berat, string memory _namaBarang) public {
        
        Paket memory Barang = Paket ({
            pengirim: msg.sender,
            penerima: _penerima,
            berat: _berat,
            namaBarang: _namaBarang,
            status: Status.DalamPengiriman
        });

        daftarBarang.push(Barang);
    }

    function listBarang() public view returns (address[] memory, uint[] memory, string[] memory, string[] memory) {
        uint totalBarang = daftarBarang.length;
        
        address[] memory penerima = new address[](totalBarang);
        uint[] memory berat = new uint[](totalBarang);
        string[] memory namaBarang = new string[](totalBarang);
        string[] memory status = new string[](totalBarang);

        for (uint i = 0; i < totalBarang; i++) {
            penerima[i] = daftarBarang[i].penerima;
            berat[i] = daftarBarang[i].berat;
            namaBarang[i] = daftarBarang[i].namaBarang;
            status[i] = getStatusString(daftarBarang[i].status);
        }

        return (penerima, berat, namaBarang, status);
    }

    function getStatusString(Status status) private pure returns (string memory) {
        if (status == Status.DalamPengiriman) {
            return "Dalam Pengiriman";
        } else if (status == Status.Diterima) {
            return "Diterima";
        } else if (status == Status.Gagal) {
            return "Gagal";
        } else {
            return "Status Tidak Valid";
        }
    }

    function terimaBarang(address _penerima) public {
        for (uint i = 0; i < daftarBarang.length; i++) {
            if (daftarBarang[i].penerima == _penerima) {
                daftarBarang[i].status = Status.Diterima;
                break;
            }
        }
    }

    function jumlahBarang() public view returns(uint) {
        uint a=0;
        for (uint i = 0; i < daftarBarang.length; i++) {
            if (daftarBarang[i].status == Status.Diterima) {
                a +=1;
            }
        }
        return daftarBarang.length - a;
    }
}
