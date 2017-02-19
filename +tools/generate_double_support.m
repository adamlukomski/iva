function q_bent = generowanie_pozycji_uderzenia_v2( step_length, ratio, ratio_vertical)
% generowanie_pozycji_uderzenia_v2( step_length, ratio, ratio_vertical )
% generowanie_pozycji_uderzenia_v2( 0.2, 0.5, 0.95 )
% segmenty nogi maja dlugosc 1, tors 1
% wszystko liczone wzgledem punktu dolnego torsu (p3)

global eva

% wysokosc robota - od torsu do konca pierwszej nogi
H = 3*1;
% dlugosc nogi (femur+tibia)
leg_length = 2*1;

% dlugosc kroku - na razie 20% wysokosci
%  L = 0.2 * H;
L = step_length * H;

% kat torsu zostaje na razie constant
q3 = pi/8;

% lecimy od sufitu: ustalam punkt (0,0,0) jako tors, pracuje w (x,z)
p2 = [0;0;0;1];
q1 = 0;
q2 = 0;

p3 = robot.p( 3, [q1;q2;q3] ); % abuse of notation !

% ile mam do nogi support of środka? ratio się liczy of support do COM

%  ratio = 0.4;
support_offset_x = ratio * L;
support_offset_z = sqrt( leg_length^2-support_offset_x^2);
swing_offset_x = (1-ratio)*L;
swing_offset_z = support_offset_z; % bo ma dotknac gruntu, moze nie byc prosta


% pozycja_extended - prosta noga idealnie
q4_absolute = asin(support_offset_x / leg_length);
q4_extended = q4_absolute - q3;
% kolano w pozycji extended jest proste
q5_extended = 0;

% druga noga juz niekoniecznie jest prosta
% wiadomo ze ma dotkac gruntu

% to najpierw na wprost
q6_tmp = - q3 - atan(swing_offset_x / swing_offset_z);

leg_length_swing_extended = sqrt( swing_offset_z^2 + swing_offset_x^2);
q6_extended_mod = acos(0.5*leg_length_swing_extended/1); % 1 - femur length
q6_extended = q6_tmp - q6_extended_mod; 
q7_extended = 2*q6_extended_mod; % kolano

% a teraz zgiecie:

% jaki ma byc vertical ratio ? czyli: jezeli 1.0 to jest to pozycja extended, jezeli nizej - kolana sie uginaja
%  ratio_vertical = 0.95;

% pitagoras...
leg_length_bent = sqrt(( support_offset_z * ratio_vertical )^2 + support_offset_x^2);

% no to teraz liczymy kat zgiecia kolana:
% support zawsze zginamy do srodka
% na razie zalozenie dlugosc femur = tibia
q4_mod = acos(0.5*leg_length_bent/1); % 1 - femur length
q4_bent = q4_extended - q4_mod; 
q5_bent = 2*q4_mod; % kolano


leg_length_swing_bent = sqrt( (swing_offset_z * ratio_vertical)^2 + swing_offset_x^2);
q6_bent_mod = acos(0.5*leg_length_swing_bent/1); % 1 - femur length
q6_bent = q6_tmp - q6_bent_mod; 
q7_bent = 2*q6_bent_mod; % kolano

% for visualization:

q1 = 3;
q2 = 0.3;

q_extended = [q1;q2;q3;q4_extended;q5_extended;q6_extended;q7_extended];
q_bent = [q1;q2;q3;q4_bent;q5_bent;q6_bent;q7_bent];

p7 = robot.p( 7, q_bent );
p5 = robot.p( 5, q_bent );
q_bent(2) = q_bent(2) - min( p7(3), p5(3) );