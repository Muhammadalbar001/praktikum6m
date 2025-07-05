import 'package:flutter/material.dart';
import 'agenda.dart';
import 'agenda_service.dart';

class AgendaForm extends StatefulWidget {
  final Agenda? agenda;
  const AgendaForm({super.key, this.agenda});

  @override
  State<AgendaForm> createState() => _AgendaFormState();
}

class _AgendaFormState extends State<AgendaForm> {
  final _formKey = GlobalKey<FormState>();
  final _judul = TextEditingController();
  final _ket = TextEditingController();
  final _al = TextEditingController();
  final _tgl = TextEditingController();
  final _service = AgendaService();

  @override
  void initState() {
    super.initState();
    if (widget.agenda != null) {
      _judul.text = widget.agenda!.judul;
      _ket.text = widget.agenda!.keterangan;
      _al.text = widget.agenda!.alamat;
      _tgl.text = widget.agenda!.tanggal;
      
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final agenda = Agenda(
        id: widget.agenda?.id,
        judul: _judul.text,
        keterangan: _ket.text,
        alamat: _al.text,
        tanggal: _tgl.text,
        
        
      );
      try {
        if (widget.agenda == null) {
          await _service.create(agenda);
        } else {
          await _service.update(agenda.id!, agenda);
        }
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal simpan: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.agenda == null ? 'Tambah Agenda' : 'Edit Agenda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _judul,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Wajib isi judul' : null,
              ),
              TextFormField(
                controller: _ket,
                decoration: const InputDecoration(labelText: 'Keterangan'),
              ),
              TextFormField(
                controller: _al,
                decoration: const InputDecoration(labelText: 'alamat'),
              ),
              TextFormField(
                controller: _tgl,
                decoration: const InputDecoration(labelText: 'tanggal'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
