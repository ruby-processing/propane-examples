project 'xor' do

  model_version '4.0.0'
  id 'nn:xor:1.0-SNAPSHOT'
  packaging 'jar'

  description 'neural net library for xor'

  developer 'shiffman' do
    name 'DanShiffman'
    roles 'developer'
  end

  properties( 'maven.compiler.source' => '1.8',
              'project.build.sourceEncoding' => 'UTF-8',
              'polyglot.dump.pom' => 'pom.xml',
              'xor.basedir' => '${project.basedir}',
              'maven.compiler.target' => '1.8' )

  overrides do
    plugin( :jar, '2.3.2',
            'outputDirectory' =>  '${xor.basedir}/library/xor' )
  end


  build do
    default_goal 'package'
    source_directory 'src'
    final_name 'xor'
  end

end
