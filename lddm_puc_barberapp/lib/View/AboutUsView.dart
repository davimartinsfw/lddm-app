import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/NavBar.dart';
import 'package:lddm_puc_barberapp/Common/PageHeader.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:provider/provider.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  late RouteController routeController;
  String text = 'Seja bem-vindo à Barbearia Nordus, um estabelecimento que vem marcando presença no bairro Fernão Dias desde sua fundação em 2021. Nossa missão é proporcionar aos clientes não apenas um corte de cabelo impecável, mas uma experiência completa e memorável em cada visita.\n\nCom o compromisso de aprimorar constantemente nossos serviços, desenvolvemos este aplicativo exclusivo para tornar sua jornada conosco ainda mais conveniente e personalizada. Imagine a praticidade de agendar seu próximo corte de cabelo ou barba com apenas alguns toques na tela do seu celular. Com nossa plataforma móvel, essa comodidade é uma realidade.\n\nDentro do aplicativo, você encontrará uma variedade de recursos úteis. Explore nossa gama de serviços especializados, desde cortes de cabelo clássicos até tratamentos de barba de última geração. Conheça também nossa equipe de profissionais talentosos, cada um dedicado a oferecer serviços de alta qualidade e atendimento personalizado.\n\nAlém disso, o aplicativo permite que você navegue por nossa seleção de produtos premium para cuidados capilares e faciais, para que possa manter seu visual impecável entre as visitas à barbearia. E para sua conveniência, mantemos um histórico completo de todos os agendamentos que você já fez, garantindo que você nunca perca uma consulta.\n\nNa Barbearia Nordus, estamos comprometidos em proporcionar uma experiência excepcional do início ao fim. Seja você um cliente fiel ou alguém que está visitando pela primeira vez, nosso objetivo é garantir que você saia com um sorriso no rosto e se sinta confiante com sua aparência.';

  @override
  void initState() {
    super.initState();

    routeController = context.read<RouteController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageHeader('Sobre nós', routeController),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/img/clube-teste-1.png'),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 32),
                child: Column(
                  children: [
                    Text('Sobre nós', style: Util.fontStyleSB(20)),
                    Text(text, style: Util.fontStyle()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
